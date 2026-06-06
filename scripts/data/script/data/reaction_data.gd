extends Resource
class_name ReactionData


@export var reaction_id: String = ""
@export var reaction_name: String = ""
@export var description: String = ""


@export var attack_elements: Array[ElementManager.Element] = []
@export var target_elements: Array[ElementManager.Element] = []


@export var damage_multiplier: float = 1.0
@export var consume_mode: ConsumeMode = ConsumeMode.BOTH


@export var extra_effects: Array[EffectData] = []


enum ConsumeMode {
    BOTH,
    ATTACK_ONLY,
    TARGET_ONLY,
    NONE,
}


func _get_property_list():
    return []