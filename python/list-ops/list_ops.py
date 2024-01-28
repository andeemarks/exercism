def append(list1, list2):
    return filter_into(list1, lambda x: x, list2)


def concat(lists):
    return [x for row in lists for x in row]


def filter(function, list):
    return filter_into([], function, list)


def filter_into(result, function, list):
    for item in list:
        if function(item):
            result.append(item)

    return result


def length(list):
    result = 0
    for item in list:
        result += 1

    return result


def map(function, list):
    return [function(item) for item in list]


def foldl(function, list, initial):
    for item in list:
        initial = function(initial, item)

    return initial


def foldr(function, list, initial):
    return foldl(function, reverse(list), initial)


def reverse(list):
    return [item for item in list[::-1]]
