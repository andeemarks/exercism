import re


def parse(markdown):
    html = ''
    in_list = False
    in_list_append = False
    for markdown_line in markdown.split('\n'):
        line, in_list, in_list_append = parse_line(markdown_line, in_list, in_list_append)
        html += line
    if in_list:
        html += '</ul>'

    return html

def parse_line(line, in_list, in_list_append):
    line, in_list, in_list_append = translate_list_item(line, in_list, in_list_append)
    line = translate_headings(line)
    line = translate_strong(line)
    line = translate_emphasis(line)
    line = translate_unadorned(line)
    if in_list_append:
        line = '</ul>' + line
        in_list_append = False

    return  line, in_list, in_list_append

def translate_list_item(line, in_list, in_list_append):
    list_item = re.match(r'\* (.*)', line)
    if list_item:
        list_text = translate_strong(list_item.group(1))
        list_text = translate_emphasis(list_text)
        line = wrap(list_text, 'li')
        if not in_list:
            in_list = True
            line = '<ul>' + line
    else:
        if in_list:
            in_list_append = True
            in_list = False

    return line, in_list, in_list_append

def translate_headings(line):
    line = wrap_if_found(line, '###### (.*)', "h6")
    line = wrap_if_found(line, '##### (.*)', "h5")
    line = wrap_if_found(line, '#### (.*)', "h4")
    line = wrap_if_found(line, '### (.*)', "h3")
    line = wrap_if_found(line, '## (.*)', "h2")
    return wrap_if_found(line, '# (.*)', "h1")

def translate_unadorned(line):
    line_already_translated = re.match('<h|<ul|<p|<li', line)

    return line if line_already_translated else wrap(line, "p")

def translate_strong(line):
    return inner_wrap_if_found(line, '(.*)__(.*)__(.*)', "strong")

def translate_emphasis(line):
    return inner_wrap_if_found(line, '(.*)_(.*)_(.*)', "em")

def inner_wrap_if_found(line, match_re, tag):
    found = re.match(match_re, line)

    return found.group(1) + wrap(found.group(2), tag) + found.group(3) if found else line

def wrap_if_found(line, match_re, tag):
    found = re.match(match_re, line)

    return wrap(found.group(1), tag) if found else line

def wrap(element, tag):
    return f"<{tag}>{element}</{tag}>"
