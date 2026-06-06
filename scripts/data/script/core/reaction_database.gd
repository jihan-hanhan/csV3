extends Node
class_name ReactionDatabase

var _reaction_map: Dictionary = {}
var _reaction_by_id: Dictionary = {}
var _is_loaded: bool = false


func load_reactions(directory_path: String = "res://data/reactions/") -> bool:
    _reaction_map.clear()
    _reaction_by_id.clear()
    
    var dir = DirAccess.open(directory_path)
    if not dir:
        print("[ReactionDatabase] 无法打开目录: ", directory_path)
        return false
    
    var loaded_count = 0
    var skipped_count = 0
    
    for file_name in dir.get_files():
        if not file_name.ends_with(".tres"):
            continue
        
        var file_path = directory_path + file_name
        var reaction: ReactionData = load(file_path)
        
        if not reaction:
            print("[ReactionDatabase] 加载失败: ", file_name)
            skipped_count += 1
            continue
        
        if not _validate_reaction(reaction):
            print("[ReactionDatabase] 数据无效: ", reaction.reaction_name)
            skipped_count += 1
            continue
        
        _index_reaction(reaction)
        
        if reaction.reaction_id:
            _reaction_by_id[reaction.reaction_id] = reaction
        
        loaded_count += 1
        print("[ReactionDatabase] 已加载: ", reaction.reaction_name)
    
    _is_loaded = true
    print("[ReactionDatabase] 加载完成! 共 ", loaded_count, 
          " 个反应, ", _reaction_map.size(), " 条映射, 跳过 ", skipped_count, " 个")
    return true


func _validate_reaction(reaction: ReactionData) -> bool:
    if reaction.attack_elements.is_empty():
        return false
    if reaction.target_elements.is_empty():
        return false
    if reaction.damage_multiplier <= 0:
        return false
    return true


func _index_reaction(reaction: ReactionData):
    for attack in reaction.attack_elements:
        for target in reaction.target_elements:
            if attack == target:
                continue
            
            var key = _make_key(attack, target)
            
            if _reaction_map.has(key):
                var existing = _reaction_map[key]
                print("[ReactionDatabase] 冲突! key=", key, 
                        " 已被 '", existing.reaction_name, "' 占用, 跳过 '", 
                        reaction.reaction_name, "'")
                continue
            
            _reaction_map[key] = reaction


func _make_key(attack: ElementManager.Element, target: ElementManager.Element) -> String:
    return str(attack) + "|" + str(target)


func get_reaction(attack: ElementManager.Element, target: ElementManager.Element) -> ReactionData:
    if not _is_loaded:
        print("[ReactionDatabase] 尚未加载数据！")
        return null
    
    var key = _make_key(attack, target)
    var reaction = _reaction_map.get(key)
    
    # 如果没找到，尝试反向查询（有些反应是双向的）
    # if not reaction:
    #     var swapped_key = _make_key(target, attack)
    #     reaction = _reaction_map.get(swapped_key)
    
    return reaction


func get_reaction_by_id(reaction_id: String) -> ReactionData:
    return _reaction_by_id.get(reaction_id)


func has_reaction(attack: ElementManager.Element, target: ElementManager.Element) -> bool:
    return get_reaction(attack, target) != null


func get_all_reactions() -> Array[ReactionData]:
    var unique: Dictionary = {}
    for reaction in _reaction_map.values():
        unique[reaction.resource_path] = reaction
    return unique.values()


func get_all_keys() -> Array[String]:
    return _reaction_map.keys()


func hot_reload(directory_path: String = "res://data/reactions/") -> bool:
    print("[ReactionDatabase] 热重载中...")
    return load_reactions(directory_path)


func _to_string() -> String:
    return "ReactionDatabase[loaded=%s, maps=%d, reactions=%d]" % [
        _is_loaded, 
        _reaction_map.size(), 
        _reaction_by_id.size()
    ]
