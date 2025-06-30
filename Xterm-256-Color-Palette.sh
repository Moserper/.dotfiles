# #!/bin/bash

# # Function to convert an ANSI color code (0-255) to an RGB hex string (#RRGGBB)
# ansi_to_rgb_hex() {
#     local code=$1
#     local r g b

#     if [ "$code" -lt 16 ]; then
#         # Standard terminal colors 0-15 are not standardized.
#         # This is a common mapping.
#         case $code in
#             0) r=0; g=0; b=0 ;;       # Black
#             1) r=128; g=0; b=0 ;;     # Red
#             2) r=0; g=128; b=0 ;;     # Green
#             3) r=128; g=128; b=0 ;;   # Yellow
#             4) r=0; g=0; b=128 ;;     # Blue
#             5) r=128; g=0; b=128 ;;   # Magenta
#             6) r=0; g=128; b=128 ;;   # Cyan
#             7) r=192; g=192; b=192 ;; # White
#             8) r=128; g=128; b=128 ;; # Bright Black (Gray)
#             9) r=255; g=0; b=0 ;;     # Bright Red
#             10) r=0; g=255; b=0 ;;    # Bright Green
#             11) r=255; g=255; b=0 ;;  # Bright Yellow
#             12) r=0; g=0; b=255 ;;    # Bright Blue
#             13) r=255; g=0; b=255 ;;  # Bright Magenta
#             14) r=0; g=255; b=255 ;;  # Bright Cyan
#             15) r=255; g=255; b=255 ;;# Bright White
#         esac
#     elif [ "$code" -lt 232 ]; then
#         # Colors 16-231 are a 6x6x6 color cube.
#         # Formula: code = 16 + 36*r + 6*g + b  (where r,g,b are 0-5)
#         local i=$((code - 16))
#         local r_idx=$((i / 36))
#         local g_idx=$(( (i % 36) / 6 ))
#         local b_idx=$((i % 6))

#         # Map indices (0-5) to RGB values (0, 95, 135, 175, 215, 255)
#         local C=(0 95 135 175 215 255)
#         r=${C[$r_idx]}
#         g=${C[$g_idx]}
#         b=${C[$b_idx]}
#     else
#         # Colors 232-255 are a grayscale ramp.
#         # Formula: gray = (code - 232) * 10 + 8
#         local gray=$(((code - 232) * 10 + 8))
#         r=$gray g=$gray b=$gray
#     fi

#     printf "#%02X%02X%02X" "$r" "$g" "$b"
# }

# # Main loop to print the color chart
# for i in {0..255}; do
#     # Get the RGB hex code
#     hex_code=$(ansi_to_rgb_hex "$i")

#     # Set background to the ANSI color and print the RGB hex code
#     printf "\x1b[48;5;${i}m %-7s\e[0m" "$hex_code"

#     # Newline after 16 colors
#     [ $((($i + 1) % 16)) = 0 ] && echo
# done
# echo # final newline

#!/bin/bash

# Function to convert an ANSI color code (0-255) to a standard RGB hex string (#RRGGBB)
ansi_to_rgb_hex() {
    local code=$1
    local r g b

    if [ "$code" -lt 16 ]; then
        # CORRECTED: Standard xterm 16-color mapping
        case $code in
            0) r=0;   g=0;   b=0   ;;  # Black
            1) r=205; g=0;   b=0   ;;  # Red
            2) r=0;   g=205; b=0   ;;  # Green
            3) r=205; g=205; b=0   ;;  # Yellow
            4) r=0;   g=0;   b=238 ;;  # Blue
            5) r=205; g=0;   b=205 ;;  # Magenta
            6) r=0;   g=205; b=205 ;;  # Cyan
            7) r=229; g=229; b=229 ;;  # White (Light Gray)
            8) r=127; g=127; b=127 ;;  # Bright Black (Dark Gray)
            9) r=255; g=0;   b=0   ;;  # Bright Red
            10) r=0;  g=255; b=0   ;;  # Bright Green
            11) r=255;g=255; b=0   ;;  # Bright Yellow
            12) r=92; g=92;  b=255 ;;  # Bright Blue
            13) r=255;g=0;   b=255 ;;  # Bright Magenta
            14) r=0;  g=255; b=255 ;;  # Bright Cyan
            15) r=255;g=255; b=255 ;;  # Bright White
        esac
    elif [ "$code" -lt 232 ]; then
        # Colors 16-231 are the 6x6x6 color cube.
        local i=$((code - 16))
        local r_idx=$((i / 36))
        local g_idx=$(( (i % 36) / 6 ))
        local b_idx=$((i % 6))
        local C=(0 95 135 175 215 255)
        r=${C[$r_idx]}
        g=${C[$g_idx]}
        b=${C[$b_idx]}
    else
        # Colors 232-255 are a grayscale ramp.
        local gray=$(((code - 232) * 10 + 8))
        r=$gray g=$gray b=$gray
    fi

    printf "#%02X%02X%02X" "$r" "$g" "$b"
}

# Main loop to print the color chart
# Using a contrasting text color for better readability
for i in {0..255}; do
    hex_code=$(ansi_to_rgb_hex "$i")

    # Simple logic for contrasting text: use black text on light bg, white on dark
    # We find the average brightness of the color
    r_val=$(printf "%d" "0x${hex_code:1:2}")
    g_val=$(printf "%d" "0x${hex_code:3:2}")
    b_val=$(printf "%d" "0x${hex_code:5:2}")
    brightness=$((r_val * 299 + g_val * 587 + b_val * 114))

    if [ $brightness -gt 128000 ]; then
      fg_color_code=232 # Black
    else
      fg_color_code=15  # White
    fi

    printf "\x1b[38;5;${fg_color_code}m\x1b[48;5;${i}m %-7s\e[0m" "$hex_code"

    # Newline after 8 colors for better layout
    [ $((($i + 1) % 16)) = 0 ] && echo
done
echo # Final newline
