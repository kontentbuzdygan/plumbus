class_name Utils


static func counts(array: Array) -> Dictionary:
    var result := {}

    for item in array:
        if item in result:
            result[item] += 1
        else:
            result[item] = 1

    return result
