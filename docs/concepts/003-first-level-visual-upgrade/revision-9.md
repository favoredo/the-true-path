# Версия 9: очистка фактуры

Статус: утверждено 2026-09-13. Пользователь ответил «утверждаю» после представления обоих макетов версии 9. Утверждение относится к визуальному результату; отдельные утверждения плана и дизайна ещё впереди.

Пользователь разрешил убрать разноцветные точки, похожие на светлячков. Встроенным image_gen выполнены два прохода очистки каждого макета версии 8: приглушение пёстрых бликов и дополнительное удаление оставшихся точек. Итоговые файлы: `01-mobile-tunnel-v9.png` и `02-desktop-junction-v9.png`.

При визуальном сравнении поверхности стали спокойнее, уменьшилась россыпь ярких точек на листве и камнях. Сохранены крупные формы и образ героя. Результат — художественная очистка, не попиксельная ретушь: единичные мелкие акценты фактуры могут сохраняться. В будущих ресурсах не добавлять случайные светящиеся точки, декоративных светлячков или пёструю штриховку без отдельного требования.

Предыдущие макеты сохранены. План 003 остаётся draft. Код не менялся. Ограничение широкого макета по радиальному освещению остаётся открытым и не считается исправленным этой очисткой.

## Промпт 1 — мобильный

Clean up this mobile game illustration ONLY by removing visual noise: remove ALL tiny colored glowing dots, firefly-like specks, glitter, confetti highlights, bright yellow pinpoints and cyan/pink speckling scattered across leaves, rocks, soil and air. Restore calm painted gouache surfaces with broad coherent color shapes and soft natural shading. Leaves are matte muted greens, stones matte subdued grey-brown, dry soil earthy matte brown. Keep recognizable individual leaves, stone silhouettes and readable contours; do not blur entire image. No sparkles, no luminous dust, no embers away from flame, no point-light decorations. Retain only restrained broad warm light on surfaces immediately near torch and torch flame itself. Preserve EXACTLY the hero's selected adult silhouette, hat, jacket, satchel, low shoes, stride, location and scale. Preserve scene geometry, compact radial illumination boundary and fully black lower area, title and GUI controls. Do not change environment arrangement or add objects. Same illustrated adventure-book style, cleaner and quieter material texture.

## Промпт 2 — широкий

Clean up this desktop game illustration ONLY by removing visual noise: remove ALL tiny colored glowing dots, firefly-like specks, glitter, confetti highlights, bright yellow pinpoints and cyan/pink speckling scattered across leaves, rocks, soil and air. Restore calm painted gouache surfaces with broad coherent color shapes and soft natural shading. Leaves are matte muted greens, stones matte subdued grey-brown, dry soil earthy matte brown. Keep recognizable individual leaves, stone silhouettes and readable contours; do not blur entire image. No sparkles, no luminous dust, no embers away from flame, no point-light decorations. Retain only restrained broad warm light on surfaces immediately near torch and torch flame itself. Preserve EXACTLY the hero's selected adult silhouette, hat, jacket, satchel, low shoes, stride, location and scale. Preserve scene geometry, ruins, tree, existing illumination boundary, title and restart control. Do not change environment arrangement or add objects. Same illustrated adventure-book style, cleaner and quieter material texture.

## Промпт 3 — дополнительная очистка мобильного

Finish removing the remaining tiny yellow dots. They are unwanted artifacts, NOT leaves or pebbles: especially the round yellow pinpricks on dark foliage either side of hero and along path. Paint over EVERY isolated bright dot with the surrounding matte surface color. Repaint foliage and soil in large quiet gouache patches, absolutely NO stippling, NO point highlights, NO glitter, NO glowing dots, NO fireflies. The only small luminous shape anywhere is the torch flame. Leaf surfaces should be solid shaded shapes, stones solid shaded shapes, retaining edges. Preserve exact hero, scene layout, UI and localized darkness; this is cleanup, not redesign. Output same portrait composition.

## Промпт 4 — дополнительная очистка широкого

Finish removing the remaining tiny yellow dots. They are unwanted artifacts, NOT leaves or pebbles: especially round yellow pinpricks scattered on dark foliage below and left of arch, either side of hero, and along dirt road. Paint over EVERY isolated bright dot with surrounding matte surface color. Repaint foliage and soil in large quiet gouache patches, absolutely NO stippling, NO point highlights, NO glitter, NO glowing dots, NO fireflies. The only small luminous shape anywhere is torch flame. Leaf surfaces should be solid shaded shapes, stones solid shaded shapes, retaining edges. Preserve exact hero, scene layout, UI and existing light boundary; cleanup, not redesign. Output same landscape composition.

