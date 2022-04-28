#   0 1 2 3 4 5
#   S S S M S S 0
#   S D D D D S 1
#   S D M D D S 2
#   M D D D D S 3
#   S D D D D S 4
#   S S S S M S 5

products = ('rum', 'gunpowder', 'blunderbuss', 'ration')

merchants = {
    (3, 0): ('Northstable Island', (1.0, 1.0, 1.0, 1.0), 'Morshu'),
    (2, 2): ('Storm Reef', (1.4, 0.6, 0.6, 1.8), 'Tem'),
    (0, 3): ('White Tiger Island', (1.2, 1.6, 1.2, 0.8), 'Daniel Jacks'),
    (4, 5): ('Bishop Rock Island', (1.2, 1.4, 1.2, 1.0), 'Fred'),
}

size = 6
dsize = size - 1

def clmp(n):
    if n < 0:
        return 0
    elif n > dsize:
        return dsize
    else:
        return n


commands = []
add = lambda s: commands.append(s)
for x in range(size):
    for y in range(size):
        id = f'tile_{x}_{y}'
        if (x, y) in merchants.keys():
            # Merchants
            merchant = merchants[(x, y)]
            add(f'tile_type({id}, t_merchant)')
            for (p, m) in zip(products, merchant[1]):
                add(f'merchandise({id}, {p}, {m})')
            add(f'name({id}, \'{merchant[0]}\')')
            add(f'merchant_name({id}, \'{merchant[2]}\')')
        else:
            border = (x == 0) | (x == dsize) | (y == 0) | (y == dsize)
            if border:
                # Shallow sea
                add(f'tile_type({id}, t_shallow)')
            else:
                # Deep sea
                add(f'tile_type({id}, t_deep)')

for (dx, dy, dir) in ((1, 0, 'e'), (-1, 0, 'w'), (0, 1, 's'), (0, -1, 'n')):
    for x in range(clmp(0 - dx), clmp(dsize - dx) + 1):
        for y in range(clmp(0 - dy), clmp(dsize - dy) + 1):
            id1 = f'tile_{x}_{y}'
            id2 =f'tile_{x + dx}_{y + dy}'
            add(f'adv_path({id1}, {dir}, {id2})')

commands.sort()
with open('map.pl', 'w') as file:
    for command in commands:
        file.write(f'assert({command}).\n')
