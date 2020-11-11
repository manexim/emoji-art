/*
 * Copyright (c) 2019 Manexim (https://github.com/manexim)
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

public class Views.PaintView : Gtk.Box {
    private Models.Paint paint;
    private Gtk.Box palette;
    private Gtk.FlowBox surface;

    public PaintView (Models.Paint paint) {
        this.paint = paint;

        for (int i = 0; i < paint.palette.length; i++) {
            var color = paint.palette[i];
            var button = new Gtk.Button () {
                label = color
            };

            button.clicked.connect (() => {
                paint.brush = color;
            });

            palette.add (button);
        }

        surface.min_children_per_line = paint.width;
        surface.max_children_per_line = paint.width;

        for (int row = 0; row < paint.height; row++) {
            for (int column = 0; column < paint.width; column++) {
                var x = column;
                var y = row;

                var button = new Gtk.Button () {
                    label = paint.surface[(y * paint.width) + x]
                };

                button.clicked.connect (() => {
                    paint.surface[(y * paint.width) + x] = paint.brush;
                    button.label = paint.brush;
                });

                surface.add (button);
            }
        }
    }

    construct {
        orientation = Gtk.Orientation.VERTICAL;

        surface = new Gtk.FlowBox () {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER,
            hexpand = true,
            vexpand = true
        };

        palette = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
            halign = Gtk.Align.CENTER
        };

        add (surface);
        add (palette);
    }
}
