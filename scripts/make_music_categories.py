import os

exclusion_keys = {
    "#",
    "@",
    "modifier",
    "character_modifier",
    "if",
    "else",
    "elseif",
    "else_if",
    "\n",
    "can_have",
    "can_keep",
    "can_pass",
    "on_pass",
    "on_revoke",
    "should_start_with",
    "graphical_cultures",
    "pass_cost",
    "desc",
    "compatibility",
    "name",
    "opposites",
    "triggered_opinion",
    "icon",
    "random_list",
    "limit",
    "random"
}

def should_read(x,level=0):
    y = x.split("#")[0]
    z = y.split("=")[0]
    return ("= {" in y and z.count("\t")+z.count("    ") == level and not z.strip() in exclusion_keys) #"#" and not y[0]=="@")

def object_reader(filepath, should_read):
    keylist = []
    with open(filepath,"r",encoding='utf-8-sig') as objfile:
        for line in (y for y in objfile.readlines() if should_read(y)):
            keylist += [line.split("=").pop(0).replace(" ", "").replace("\t", "")]
    return keylist

def parse_directory(dir):
    li = {}
    lamb = lambda x: should_read(x)
    for file in os.scandir(path=dir):
        if file.name.endswith(".txt") and not file.name == "output.txt":
            li.update( {file.path: object_reader(file.path, lamb)})

    values = li.keys()
    count = 0
    with open("output.txt", "a") as file:
        for i in values:
            i_id = i.replace(".\\", "").replace(".txt", "")
            i_name = i.replace(".\\", "").replace(".txt", "")
            file.write(f"category = {{\n\tid = \"id_{i_id}\"\n\tname = \"name_`{i_name}\"\n\ttracks = {{\n")
            for z in li[i]:
                count += 1
                file.write(f"\t\t\"{z}\"\n")
            file.write("\t}\n}\n")
            #file.write("\n")

    print(f"{count} tracks processed")

def parse_file(filepath):
    li = {}
    lamb = lambda x: should_read(x)
    li.update( {filepath: object_reader(filepath, lamb)})
    values = li.values()
    for i in values:
        for z in i: print(z)


def print_output(dir_list):
    if os.path.exists("output.txt"):
        os.remove("output.txt")
    for directory in dir_list:
        if os.path.exists(directory):
            parse_directory(directory)

if __name__ == '__main__':
    print_output(["."])
    #parse_file("C:\\Users\\demen\\Desktop\\Python\\pdxObjectParse\\mp_plus.txt")
