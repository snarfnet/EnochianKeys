"""Enochian Keys App Icon - Celestial/Cosmic design"""
from PIL import Image, ImageDraw, ImageFont
import math

SIZE = 1024
img = Image.new('RGB', (SIZE, SIZE), (5, 5, 20))
draw = ImageDraw.Draw(img)

# Deep space gradient
for y in range(SIZE):
    ratio = y / SIZE
    r = int(5 + 20 * math.sin(ratio * math.pi))
    g = int(5 + 10 * math.sin(ratio * math.pi))
    b = int(20 + 40 * math.sin(ratio * math.pi))
    draw.line([(0, y), (SIZE, y)], fill=(r, g, b))

# Stars
import random
random.seed(42)
for _ in range(80):
    x = random.randint(0, SIZE)
    y = random.randint(0, SIZE)
    s = random.randint(1, 3)
    bright = random.randint(100, 220)
    draw.ellipse([x, y, x+s, y+s], fill=(bright, bright, int(bright*1.1)))

# Nebula glow
for _ in range(5):
    cx = random.randint(200, 800)
    cy = random.randint(200, 800)
    for r in range(150, 0, -1):
        alpha = int(8 * (1 - r/150))
        color = (30 + alpha*3, 15 + alpha, 60 + alpha*4)
        draw.ellipse([cx-r, cy-r, cx+r, cy+r], fill=None, outline=color)

# Heptagram (7-pointed star)
center = SIZE // 2
radius = 300
cyan = (51, 191, 230)
blue_glow = (77, 140, 242)

# Outer circle
draw.ellipse([center-radius-30, center-radius-30, center+radius+30, center+radius+30],
             outline=blue_glow, width=2)
draw.ellipse([center-radius-20, center-radius-20, center+radius+20, center+radius+20],
             outline=(40, 80, 160), width=1)

# Heptagram
points = []
for i in range(7):
    angle = (i * 4 * math.pi / 7) - math.pi / 2
    px = center + radius * math.cos(angle)
    py = center + radius * math.sin(angle)
    points.append((px, py))

for i in range(7):
    draw.line([points[i], points[(i+1)%7]], fill=cyan, width=3)

# Inner circle
inner_r = radius * 0.5
draw.ellipse([center-inner_r, center-inner_r, center+inner_r, center+inner_r],
             outline=blue_glow, width=2)

# Central glow
for r in range(80, 0, -1):
    alpha = int(15 * (1 - r/80))
    draw.ellipse([center-r, center-r, center+r, center+r],
                 fill=(20+alpha*2, 40+alpha*3, 80+alpha*5))

# Triangle in center
tri_r = 60
for i in range(3):
    a1 = (i * 2 * math.pi / 3) - math.pi / 2
    a2 = ((i+1) * 2 * math.pi / 3) - math.pi / 2
    draw.line([
        (center + tri_r * math.cos(a1), center + tri_r * math.sin(a1)),
        (center + tri_r * math.cos(a2), center + tri_r * math.sin(a2))
    ], fill=cyan, width=2)

# Center dot
draw.ellipse([center-5, center-5, center+5, center+5], fill=(200, 220, 255))

# Title text
try:
    font = ImageFont.truetype("C:/Windows/Fonts/times.ttf", 56)
    font_small = ImageFont.truetype("C:/Windows/Fonts/times.ttf", 32)
except:
    font = ImageFont.load_default()
    font_small = font

# "ENOCHIAN" at bottom
text = "ENOCHIAN"
bbox = draw.textbbox((0, 0), text, font=font)
tw = bbox[2] - bbox[0]
draw.text(((SIZE - tw) // 2, SIZE - 200), text, fill=cyan, font=font)

# "KEYS" below
text2 = "KEYS"
bbox2 = draw.textbbox((0, 0), text2, font=font_small)
tw2 = bbox2[2] - bbox2[0]
draw.text(((SIZE - tw2) // 2, SIZE - 130), text2, fill=(120, 150, 200), font=font_small)

import os
output = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "EnochianKeys", "Assets.xcassets", "AppIcon.appiconset", "icon_1024.png")
img.save(output, "PNG")
print(f"Icon saved: {output}")
img.save(os.path.join(os.path.dirname(os.path.abspath(__file__)), "AppIcon.png"), "PNG")
print("Also saved AppIcon.png")
