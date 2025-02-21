extends Resource
class_name Recipe

@export var requirements: Array[RecipeRequirement]
@export var result: Item
@export var time_seconds: float


func matches(items: Array[Item]) -> bool:
    var items_counts := Utils.counts(items)

    if items_counts.size() != requirements.size():
        return false

    for requirement in requirements:
        if requirement.item not in items_counts or items_counts[requirement.item] < requirement.count:
            return false

    return true
