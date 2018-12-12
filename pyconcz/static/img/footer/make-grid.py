import numpy
import sys

numpy.random.seed(0)

ZOOM = 4
GRID_X = 3.9 * ZOOM
GRID_Y = 2.25 * ZOOM

ROWS = 100 // ZOOM
ROWS += (ROWS % 2)
COLS = 50 // ZOOM
MAX_OFFSET = 5

WIDTH = COLS+1
HEIGHT = ROWS

COMMON_STYLE = "stroke-width: 1px;"

def randrange(size=None):
    result = numpy.random.random(size) * MAX_OFFSET
    if size:
        return result.astype(int)
    else:
        return int(result)

offsets = randrange((HEIGHT, WIDTH))

while True:
    changed = set()

    for row_index, row in enumerate(offsets):
        for col_index, value in enumerate(row):
            if row_index % 2:
                col_left = col_index - 1
            else:
                col_left = col_index
            neighbor_values = [
                offsets[r % HEIGHT, c % (WIDTH)]
                for (r, c) in (
                    (row_index-1, col_left),
                    (row_index-1, col_left+1),
                    (row_index, col_index-1),
                    (row_index-2, col_index),
                )
            ]
            while value in neighbor_values:
                changed.add((row_index, col_index))
                value = randrange()
                offsets[row_index, col_index] = value
    if not changed:
        break

offsets = numpy.hstack((offsets, offsets[:, :1]))
offsets = numpy.vstack((offsets, offsets[:4]))


for ri, row in enumerate(offsets):
    print(f'{ri:02}', end=' ', file=sys.stderr)
    if ri%2:
        print('≤ ', end='', file=sys.stderr)
    else:
        print('>  ', end='', file=sys.stderr)
    print(row, file=sys.stderr)

print('<?xml version="1.0" encoding="UTF-8" standalone="no"?>')
gx = GRID_X
gy = GRID_Y
print(f"""
    <svg
        id="main"
        width="{(COLS+1)*6*GRID_X}" height="{(ROWS*2+MAX_OFFSET+4)*GRID_Y}"
        xmlns="http://www.w3.org/2000/svg"
    >
    <symbol id="fc" width="{6*GRID_X}" height="{14*GRID_Y}">
        <path style="fill: #e6e8ef; stroke: #e6e8ef; {COMMON_STYLE}"
            d="m {0},{gy*2} {gx*3},{-gy*2} {gx*3},{gy*2} {-gx*3},{gy*2} z"
        />
        <path style="fill: #f0f2f8; stroke: #f0f2f8; {COMMON_STYLE}"
            d="m {0},{gy*2} {gx*3},{gy*2} {0},{gy*20} {-gx*3},{-gy*2} z"
        />
        <path style="fill: #e0e2e8; stroke: #e0e2e8; {COMMON_STYLE}"
            d="m {gx*3},{gy*4} {gx*3},{-gy*2} {0},{gy*20} {-gx*3},{gy*2} z"
        />
    </symbol>
""")
print("""
        <style>
        /* <![CDATA[ */
            use {
                transition-property: transform;
                transition-duration: 1s;
                transition-timing-function: linear;
            }
            use:hover {
                transform: translate(0, {X}px);
            }
        /* ]]> */
        </style>
""".replace('{X}', str(GRID_Y * MAX_OFFSET)))
for row_index, row in enumerate(offsets):
    for col_index, value in enumerate(row):
        if row_index % 2:
            x = (col_index - 0.5) * GRID_X * 6
        else:
            x = col_index * GRID_X * 6
        y = row_index * GRID_Y * 2 - value * GRID_Y + GRID_Y * MAX_OFFSET
        print(f"""<use href="#fc" x="{round(x, 3)}" y="{round(y, 3)}" />""")
print('</svg>')
