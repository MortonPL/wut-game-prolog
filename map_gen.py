from typing import Dict, Tuple

#   0 1 2 3 4 5
#   S S S M S S 0
#   S D D D D S 1
#   S D M D D S 2
#   M D D D D S 3
#   S D D D D S 4
#   S S S S M S 5

class Merchant:
    def __init__(self, island_name, merchant_name, merchant_prompt, merchant_topics, sell, buy):
        self.island_name = island_name
        self.merchant_name = merchant_name
        self.merchant_prompt = merchant_prompt
        self.merchant_topics = merchant_topics
        self.sell = sell
        self.buy = buy

merchants: Dict[Tuple[int, int], Merchant] = {
    (3, 0): Merchant(
        'Northstable Island',
        'Morshu',
        'Bomb, ropes, lamp oil. You want it? It\'\'s yours my friend.',
        [
            ('merchants', 'There are two other islands to the south-east.')
        ],
        {
            'rum': 1.0,
            'gunpowder': 1.0,
            'blunderbuss': 1.0,
            'ration': 1.0,
            'banana': 1.0,
        }, {
            'rum': 0.9,
            'gunpowder': 0.9,
            'blunderbuss': 0.9,
            'ration': 0.9,
            'banana': 0.9,
        }),
    (2, 2): Merchant(
        'Storm Reef',
        'Tem',
        'Tem go to colleg ye-ya!',
        [
            ('merchants', 'sail eestwardz')
        ],
        {
            'rum': 1.4,
            'gunpowder': 0.6,
            'blunderbuss': 0.6,
            'ration': 1.8,
            'map_piece_1': 1.0,
        }, {
            'rum': 1.3,
            'gunpowder': 0.5,
            'blunderbuss': 0.5,
            'ration': 1.7,
            'banana': 1.1,
        }),
    (0, 3): Merchant(
        'White Tiger Island',
        'Daniel Jacks',
        'My business was ruined by those pirate folk...',
        [
            ('merchants', 'If you\'\'re brave enough, try east-northeast!')
        ],
        {
            'rum': 1.2,
            'gunpowder': 1.6,
            'blunderbuss': 1.2,
            'ration': 0.8,
            'mercenary': 1.0,
        }, {
            'rum': 1.1,
            'gunpowder': 1.5,
            'blunderbuss': 1.1,
            'ration': 0.7,
            'banana': 1.3,
        }),
    (4, 5): Merchant(
        'Bishop Rock Island',
        'Fred',
        'Good evening.',
        [
            ('merchants', 'Other ships often take a course towards north...')
        ],
        {
            'rum': 1.2,
            'gunpowder': 1.4,
            'blunderbuss': 1.2,
            'ration': 1.0,
            'mercenary': 0.8,
        }, {
            'rum': 1.1,
            'gunpowder': 1.3,
            'blunderbuss': 1.1,
            'ration': 0.9,
            'banana': 1.6,
        }),
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
            for (p, m) in merchant.sell.items():
                add(f'selling({id}, {p}, {m})')
            for (p, m) in merchant.buy.items():
                add(f'buying({id}, {p}, {m})')
            add(f'island_name({id}, \'{merchant.island_name}\')')
            add(f'merchant_name({id}, \'{merchant.merchant_name}\')')
            add(f'merchant_prompt({id}, \'{merchant.merchant_prompt}\')')
            for (topic, answer) in merchant.merchant_topics:
                add(f'merchant_topic({id}, {topic}, \'{answer}\')')
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
            add(f'path({id1}, {dir}, {id2})')

commands.sort()
with open('map.pl', 'w') as file:
    for command in commands:
        file.write(f':-assert(map_{command}).\n')
