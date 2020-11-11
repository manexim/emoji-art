/*
 * Copyright (c) 2020 Manexim (https://github.com/manexim)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Marius Meisenzahl <mariusmeisenzahl@gmail.com>
 */

public class Models.Paint : Object {
    private int _width;
    private int _height;

    public string[] palette { get; set; }
    public string brush { get; set; }
    public string[] surface { get; set; }
    public int width { get { return _width; } }
    public int height { get { return _height; } }

    public Paint (int width, int height) {
        _width = width;
        _height = height;

        surface = new string[width * height];

        for (int row = 0; row < height; row++) {
            for (int column = 0; column < width; column++) {
                surface[(row * width) + column] = "⬜";
            }
        }
    }

    construct {
        palette = {"⬛", "🟥", "🟫", "🟪", "🟩", "🟨", "🟧", "🟦", "⬜"};
        brush = palette[0];
    }

    public string to_string () {
        string result = "";

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                result += surface[(y * width) + x];
            }

            result += "\n";
        }

        return result.strip ();
    }
}
