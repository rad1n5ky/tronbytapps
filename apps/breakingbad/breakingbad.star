"""
Applet: BreakingBad
Summary: Breaking Bad TV Credit
Description: Display credit in Breaking Bad TV show format.
Author: Robert Ison
"""

load("encoding/base64.star", "base64")
load("render.star", "render")
load("schema.star", "schema")

SMOKE = base64.decode("""
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
""")

FONT = "6x10"
ELEMENT_GREEN = "#094b3f"
WHITE = "#FFF"

elements = {
    "H": "Hydrogen",
    "He": "Helium",
    "Li": "Lithium",
    "Be": "Beryllium",
    "B": "Boron",
    "C": "Carbon",
    "N": "Nitrogen",
    "O": "Oxygen",
    "F": "Fluorine",
    "Ne": "Neon",
    "Na": "Sodium",
    "Mg": "Magnesium",
    "Al": "Aluminum",
    "Si": "Silicon",
    "P": "Phosphorus",
    "S": "Sulfur",
    "Cl": "Chlorine",
    "Ar": "Argon",
    "K": "Potassium",
    "Ca": "Calcium",
    "Sc": "Scandium",
    "Ti": "Titanium",
    "V": "Vanadium",
    "Cr": "Chromium",
    "Mn": "Manganese",
    "Fe": "Iron",
    "Co": "Cobalt",
    "Ni": "Nickel",
    "Cu": "Copper",
    "Zn": "Zinc",
    "Ga": "Gallium",
    "Ge": "Germanium",
    "As": "Arsenic",
    "Se": "Selenium",
    "Br": "Bromine",
    "Kr": "Krypton",
    "Rb": "Rubidium",
    "Sr": "Strontium",
    "Y": "Yttrium",
    "Zr": "Zirconium",
    "Nb": "Niobium",
    "Mo": "Molybdenum",
    "Tc": "Technetium",
    "Ru": "Ruthenium",
    "Rh": "Rhodium",
    "Pd": "Palladium",
    "Ag": "Silver",
    "Cd": "Cadmium",
    "In": "Indium",
    "Sn": "Tin",
    "Sb": "Antimony",
    "Te": "Tellurium",
    "I": "Iodine",
    "Xe": "Xenon",
    "Cs": "Cesium",
    "Ba": "Barium",
    "La": "Lanthanum",
    "Ce": "Cerium",
    "Pr": "Praseodymium",
    "Nd": "Neodymium",
    "Pm": "Promethium",
    "Sm": "Samarium",
    "Eu": "Europium",
    "Gd": "Gadolinium",
    "Tb": "Terbium",
    "Dy": "Dysprosium",
    "Ho": "Holmium",
    "Er": "Erbium",
    "Tm": "Thulium",
    "Yb": "Ytterbium",
    "Lu": "Lutetium",
    "Hf": "Hafnium",
    "Ta": "Tantalum",
    "W": "Tungsten",
    "Re": "Rhenium",
    "Os": "Osmium",
    "Ir": "Iridium",
    "Pt": "Platinum",
    "Au": "Gold",
    "Hg": "Mercury",
    "Tl": "Thallium",
    "Pb": "Lead",
    "Bi": "Bismuth",
    "Po": "Polonium",
    "At": "Astatine",
    "Rn": "Radon",
    "Fr": "Francium",
    "Ra": "Radium",
    "Ac": "Actinium",
    "Th": "Thorium",
    "Pa": "Protactinium",
    "U": "Uranium",
    "Np": "Neptunium",
    "Pu": "Plutonium",
    "Am": "Americium",
    "Cm": "Curium",
    "Bk": "Berkelium",
    "Cf": "Californium",
    "Es": "Einsteinium",
    "Fm": "Fermium",
    "Md": "Mendelevium",
    "No": "Nobelium",
    "Lr": "Lawrencium",
    "Rf": "Rutherfordium",
    "Db": "Dubnium",
    "Sg": "Seaborgium",
    "Bh": "Bohrium",
    "Hs": "Hassium",
    "Mt": "Meitnerium",
    "Ds": "Darmstadtium",
    "Rg": "Roentgentium",
    "Cn": "Copernicum",
    "Nh": "Nihonium",
    "Fl": "Flerovium",
    "Mc": "Moscovium",
    "Lv": "Livermorium",
    "Ts": "Tennessine",
    "Og": "Oganesson",
}

def main(config):
    line1 = config.str("line1", "Breaking")
    line2 = config.str("line2", "  Bad")
    show_smoke = config.bool("show_image", True)

    return render.Root(
        child = render.Stack(
            children = [
                render.Image(src = SMOKE) if show_smoke else None,
                get_display_children_for_given_breakdown(1, find_element_symbol(line1)),
                get_display_children_for_given_breakdown(2, find_element_symbol(line2)),
            ],
        ),
        delay = 200,
    )

def get_display_children_for_given_breakdown(row, breakdown):
    items = []

    height_offset = 1 + 15 * (int(row) - 1)
    left_offset = 1 + 3 * (int(row) - 1)
    text_height_difference = 2

    prefix = breakdown[0]
    element = breakdown[1]
    suffix = breakdown[2]

    if (len(prefix) > 0):
        items.insert(len(items), add_padding_to_child_element(render.Text(prefix.strip(), font = FONT), left_offset, height_offset + text_height_difference))

    left_offset = left_offset + 6 * len(prefix)

    if (len(element) > 0):
        items.insert(len(items), add_padding_to_child_element(get_element_box_children(element), left_offset, height_offset))
        left_offset = left_offset + 14

    if (len(suffix) > 0):
        items.insert(len(items), add_padding_to_child_element(render.Text(suffix.strip(), font = FONT), left_offset, height_offset + text_height_difference))

    return render.Stack(items)

def get_element_box_children(element):
    return render.Box(width = 13, height = 14, color = WHITE, child = render.Box(width = 11, height = 12, color = ELEMENT_GREEN, child = add_padding_to_child_element(render.Text(element), 1)))

def find_element_symbol(name):
    for length in (2, 1):  # Check 2-letter symbols first, then 1-letter
        for i in range(len(name) - (length - 1)):
            if name[i:i + length].capitalize() in elements:
                return name[:i], name[i:i + length].capitalize(), name[i + length:]

    return name, "", ""

def add_padding_to_child_element(element, left = 0, top = 0, right = 0, bottom = 0):
    padded_element = render.Padding(
        pad = (left, top, right, bottom),
        child = element,
    )

    return padded_element

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [
            schema.Text(
                id = "line1",
                name = "Line 1",
                desc = "First Name",
                icon = "pencil",
            ),
            schema.Text(
                id = "line2",
                name = "Line 2",
                desc = "Last Name",
                icon = "pencil",
            ),
            schema.Toggle(
                id = "show_image",
                name = "Show background image?",
                desc = "Display the smoking background?",
                icon = "fireFlameCurved",
            ),
        ],
    )
