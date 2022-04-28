#   0 1 2 3 4 5
#   S S S M S S 0
#   S D D D D S 1
#   S D M D D S 2
#   M D D D D S 3
#   S D D D D S 4
#   S S S S M S 5

products = ('rum', 'gunpowder', 'blunderbuss', 'ration')

merchants = {
    (3, 0): ('Northstable Island', (1.0, 1.0, 1.0, 1.0)),
    (2, 2): ('Storm Reef', (1.4, 0.6, 0.6, 1.8)),
    (0, 3): ('White Tiger Island', (1.2, 1.6, 1.2, 0.8)),
    (4, 5): ('Bishop Rock Island', (1.2, 1.4, 1.2, 1.0)),
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

with open('map.pl', 'w') as file:
    file.write('% Tiles\n')
    for x in range(size):
        for y in range(size):
            id = f'tile_{x}_{y}'
            if (x, y) in merchants.keys():
                # Merchants
                merchant = merchants[(x, y)]
                file.write(f'tile_type({id}, t_merchant).\n')
                for (p, m) in zip(products, merchant[1]):
                    file.write(f'merchandise({id}, {p}, {m}).\n')
                file.write(f'name("{merchant[0]}").\n')
            else:
                border = x == 0 | x == dsize | y == 0 | y == dsize
                if border:
                    # Shallow sea
                    file.write(f'tile_type({id}, t_shallow).\n')
                else:
                    # Deep sea
                    file.write(f'tile_type({id}, t_deep).\n')
    
    file.write('% Paths\n')
    for (dx, dy, dir) in ((-1, 0, 'w'), (1, 0, 'e'), (0, -1, 'n'), (0, 1, 's')):
        for x in range(clmp(0 - dx), clmp(size - dx) + 1):
            for y in range(clmp(0 - dy), clmp(size - dy) + 1):
                id1 = f'tile_{x}_{y}'
                id2 =f'tile_{x + dx}_{y + dy}'
                file.write(f'adv_path({id1}, {dir}, {id2}).\n')


