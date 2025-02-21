extends Node

class_name Player

# Signals for stat changes and status effects
signal stat_changed(stat_name: String, new_value: int)
signal status_effect_applied(effect_name: String)
signal status_effect_removed(effect_name: String)

# Exported variables for inspector customization
@export var contact: Array[Npc] = []  # Array of NPC contacts
@export var player_name: String = "Cyborg Guy"  # Default player name with a nod to prior theme
@export_category("Stat Limits")
@export var max_stat: int = 100  # Maximum value for capped stats
@export var min_stat: int = 0    # Minimum value for capped stats

# Enums for stat names and status effects to improve code safety and readability
enum Stat {
    ENERGY,
    MORAL,
    INTELLIGENCE,
    STRESS,
    ALCHEMY,  # Fixed typo: "alcolemy" -> "alchemy"
    HEALTH,
    MONEY
}

enum StatusEffect {
    EXHAUSTED,
    INSPIRED,
    OVERLOADED,
    POISONED
}

# Player stats dictionary for easier management
var stats: Dictionary = {
    Stat.ENERGY: 100,
    Stat.MORAL: 70,
    Stat.INTELLIGENCE: 30,
    Stat.STRESS: 0,
    Stat.ALCHEMY: 0,
    Stat.HEALTH: 90,
    Stat.MONEY: 500
}

# Status effects dictionary (effect -> duration in seconds)
var active_effects: Dictionary = {}

# Regeneration rates (per second)
var regen_rates: Dictionary = {
    Stat.ENERGY: 1,    # Regenerate 1 energy per second
    Stat.STRESS: -2,   # Reduce stress by 2 per second
    Stat.HEALTH: 0.5   # Regenerate 0.5 health per second
}

# Called when the node enters the scene tree for the first time
func _ready() -> void:
    print("Player '" + player_name + "' initialized with stats: ", stats)
    # Connect stat_changed signal to a debug function (optional)
    # stat_changed.connect(_on_stat_changed.bind())

# Called every frame
func _process(delta: float) -> void:
    _handle_regeneration(delta)
    _handle_status_effects(delta)

# Increment a stat by a given amount
func increment_stat(amount: int, stat: Stat) -> void:
    var stat_name: String = Stat.keys()[stat]
    var current_value: int = stats[stat]
    var new_value: int = current_value + amount
    
    # Apply caps if applicable (money has no upper limit)
    if stat != Stat.MONEY:
        new_value = clamp(new_value, min_stat, max_stat)
    else:
        new_value = max(new_value, min_stat)  # Money can’t go below 0
    
    stats[stat] = new_value
    stat_changed.emit(stat_name, new_value)
    _check_stat_effects(stat)

# Decrement a stat by a given amount, returns true if successful
func decrement_stat(amount: int, stat: Stat) -> bool:
    var stat_name: String = Stat.keys()[stat]
    var current_value: int = stats[stat]
    
    if current_value >= amount:
        var new_value: int = max(current_value - amount, min_stat)
        stats[stat] = new_value
        stat_changed.emit(stat_name, new_value)
        _check_stat_effects(stat)
        return true
    else:
        print("Not enough " + stat_name + " to decrement by " + str(amount) + "!")
        return false

# Apply a status effect with a duration
func apply_status_effect(effect: StatusEffect, duration: float) -> void:
    var effect_name: String = StatusEffect.keys()[effect]
    if not active_effects.has(effect):
        active_effects[effect] = duration
        status_effect_applied.emit(effect_name)
        print(player_name + " is now " + effect_name)
        _apply_effect_modifiers(effect, true)

# Remove a status effect
func remove_status_effect(effect: StatusEffect) -> void:
    var effect_name: String = StatusEffect.keys()[effect]
    if active_effects.erase(effect):
        status_effect_removed.emit(effect_name)
        print(player_name + " is no longer " + effect_name)
        _apply_effect_modifiers(effect, false)

# Handle stat regeneration over time
func _handle_regeneration(delta: float) -> void:
    for stat in regen_rates.keys():
        var regen_amount: float = regen_rates[stat] * delta
        if regen_amount > 0:
            increment_stat(int(regen_amount), stat)
        elif regen_amount < 0:
            decrement_stat(int(-regen_amount), stat)

# Manage status effects duration and expiration
func _handle_status_effects(delta: float) -> void:
    var expired_effects: Array = []
    for effect in active_effects.keys():
        active_effects[effect] -= delta
        if active_effects[effect] <= 0:
            expired_effects.append(effect)
    
    for effect in expired_effects:
        remove_status_effect(effect)

# Apply or remove modifiers based on status effects
func _apply_effect_modifiers(effect: StatusEffect, apply: bool) -> void:
    var multiplier: int = 1 if apply else -1
    match effect:
        StatusEffect.EXHAUSTED:
            regen_rates[Stat.ENERGY] -= 2 * multiplier  # Slows energy regen
            regen_rates[Stat.STRESS] += 1 * multiplier  # Increases stress
        StatusEffect.INSPIRED:
            regen_rates[Stat.MORAL] += 3 * multiplier   # Boosts moral regen
        StatusEffect.OVERLOADED:
            regen_rates[Stat.INTELLIGENCE] -= 1 * multiplier  # Slows intelligence
            regen_rates[Stat.STRESS] += 2 * multiplier   # Increases stress
        StatusEffect.POISONED:
            regen_rates[Stat.HEALTH] -= 2 * multiplier   # Damages health over time

# Check stats for automatic status effect triggers
func _check_stat_effects(stat: Stat) -> void:
    match stat:
        Stat.ENERGY:
            if stats[stat] <= 20 and not active_effects.has(StatusEffect.EXHAUSTED):
                apply_status_effect(StatusEffect.EXHAUSTED, 10.0)
            elif stats[stat] > 20 and active_effects.has(StatusEffect.EXHAUSTED):
                remove_status_effect(StatusEffect.EXHAUSTED)
        Stat.MORAL:
            if stats[stat] >= 80 and not active_effects.has(StatusEffect.INSPIRED):
                apply_status_effect(StatusEffect.INSPIRED, 15.0)
            elif stats[stat] < 80 and active_effects.has(StatusEffect.INSPIRED):
                remove_status_effect(StatusEffect.INSPIRED)
        Stat.STRESS:
            if stats[stat] >= 80 and not active_effects.has(StatusEffect.OVERLOADED):
                apply_status_effect(StatusEffect.OVERLOADED, 10.0)
            elif stats[stat] < 80 and active_effects.has(StatusEffect.OVERLOADED):
                remove_status_effect(StatusEffect.OVERLOADED)
        Stat.HEALTH:
            if stats[stat] <= 30 and not active_effects.has(StatusEffect.POISONED):
                apply_status_effect(StatusEffect.POISONED, 20.0)
            elif stats[stat] > 30 and active_effects.has(StatusEffect.POISONED):
                remove_status_effect(StatusEffect.POISONED)

# Save player data to a dictionary
func save_to_dict() -> Dictionary:
    return {
        "name": player_name,
        "stats": stats,
        "active_effects": active_effects
    }

# Load player data from a dictionary
func load_from_dict(data: Dictionary) -> void:
    player_name = data.get("name", "Cyborg Guy")
    stats = data.get("stats", stats)
    active_effects = data.get("active_effects", {})
    for effect in active_effects.keys():
        _apply_effect_modifiers(effect, true)

# Optional debug function for stat changes
func _on_stat_changed(stat_name: String, new_value: int) -> void:
    print(player_name + "’s " + stat_name + " is now " + str(new_value))
