extends Resource
class_name ElementManager


enum Element {
	NONE,
	PHYSICAL = 1 << 0,
	FIRE = 1 << 1,
	FREEZE = 1 << 2,
	ELECTRIC = 1 << 3,
	CORROSION = 1 << 4,
	VIBRATION = 1 << 5,
	SPIRIT = 1 << 6
}


const ELEMENT_NAMES = {
	Element.PHYSICAL: "物理",
	Element.FIRE: "灼热",
	Element.FREEZE: "寒冷",
	Element.ELECTRIC: "电磁",
	Element.CORROSION: "腐蚀",
	Element.VIBRATION: "振动",
	Element.SPIRIT: "精神"
}


static var ELEMENT_COLORS = {
    Element.PHYSICAL: Color.hex(0xAEBAC2),
    Element.FIRE: Color.hex(0xFF0000),
    Element.FREEZE: Color.hex(0x87CEFA),
    Element.ELECTRIC: Color.hex(0x7FFFAA),
    Element.CORROSION: Color.hex(0x2E8B57),
    Element.VIBRATION: Color.hex(0xFFD700),
	Element.SPIRIT: Color.hex(0x9932CC)
}


static func get_element_name(ele: Element) -> String:
	return ELEMENT_NAMES.get(ele, "未知")


static func get_element_color(ele: Element) -> Color:
	return ELEMENT_COLORS.get(ele, Color.WHITE)


static func has_element(target: Element, check: Element) -> bool:
	return (target & check) != 0


static func get_elements_list(combined: Element) -> Array[Element]:
	var result: Array[Element] = []
	for ele in Element.values():
		if ele != Element.NONE && (combined & ele):
			result.append(ele)
	return result


static func add_element(current: int, new: int) -> int:
	return current | new


static func remove_element(current: int, target: int) -> int:
	return current &~ target
