def encode(message, rails):
    zig_zag = build_zig_zag(message, rails)
    fences = [""] * rails

    for letter, i in zip(message, zig_zag):
        rail = zig_zag[i]
        fences[rail] = fences[rail] + str(letter) if fences[rail] else str(letter)

    return "".join(fences)

def build_zig_zag(message, rails):
    zig = list(range(rails))
    zag = zig[-2:0:-1]

    return ((zig + zag) * (len(message) // (rails)))[:len(message)]

def decode(encoded_message, rails):
    zig_zag = build_zig_zag(encoded_message, rails)
    splits = split_message_across_rails(encoded_message, zig_zag, rails)
    message = rebuild_message(zig_zag, splits)

    return "".join(message)

def split_message_across_rails(message, zig_zag, rails):
    splits = []
    for rail in range(0, rails):
        letters_per_rail = zig_zag.count(rail)
        splits.append(message[0:letters_per_rail])
        message = message[letters_per_rail::]

    return splits

def rebuild_message(zig_zag, splits):
    message = []
    for fence in zig_zag:
        message.append(splits[fence][0])
        splits[fence] = splits[fence][1:]

    return message
