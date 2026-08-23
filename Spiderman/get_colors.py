import sys
from PIL import Image

def get_colors(image_path):
    img = Image.open(image_path)
    img = img.convert('RGB')
    
    # Resize to speed up processing
    img.thumbnail((150, 150))
    
    pixels = list(img.getdata())
    
    reds = []
    blacks = []
    grays = []
    
    for r, g, b in pixels:
        # Determine if red
        if r > 100 and r > g * 1.5 and r > b * 1.5:
            reds.append((r, g, b))
        # Determine if black/dark
        elif r < 50 and g < 50 and b < 50:
            blacks.append((r, g, b))
        # Determine if gray
        elif abs(r - g) < 20 and abs(g - b) < 20 and abs(r - b) < 20 and 50 <= r <= 200:
            grays.append((r, g, b))
            
    def get_avg(color_list):
        if not color_list:
            return None
        avg_r = sum([c[0] for c in color_list]) // len(color_list)
        avg_g = sum([c[1] for c in color_list]) // len(color_list)
        avg_b = sum([c[2] for c in color_list]) // len(color_list)
        return (avg_r, avg_g, avg_b)
        
    print("Red:", get_avg(reds))
    print("Black:", get_avg(blacks))
    print("Gray:", get_avg(grays))

if __name__ == "__main__":
    get_colors(sys.argv[1])
