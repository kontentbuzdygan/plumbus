extends Resource
class_name Recipe

@export var requirements: Array[RecipeRequirement]
@export var result: Item
@export var time_seconds: float


func is_satisfied(items: Array[Item]) -> bool:
    var items_counts := Utils.counts(items)

    for requirement in requirements:
        if requirement.item not in items_counts or items_counts[requirement.item] < requirement.count:
            return false

    return true
