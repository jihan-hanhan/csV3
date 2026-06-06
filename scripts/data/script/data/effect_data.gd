extends Resource
class_name EffectData


@export var effect_type: EffectType = EffectType.DAMAGE
@export var value: float = 0.0
@export var duration: float = 0.0
@export var interval: float = 0.0
@export var tick_count: int = 0


enum EffectType {
    DAMAGE,
    DOT,
    SLOW,
    STUN,
    HEAL,
    BUFF,
    DEBUFF,
}