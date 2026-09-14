# Предварительные макеты первого уровня

Утверждённые макеты: **версия 9** — `01-mobile-tunnel-v9.png` и `02-desktop-junction-v9.png`. Предыдущие версии сохранены как история обсуждения.

[Очистка фактуры и промпты версии 9](revision-9.md): уменьшена россыпь цветных точек и лишних бликов, поверхности камня и листвы сделаны спокойнее. Оба изображения утверждены пользователем 2026-09-13 сообщением «утверждаю».

Пользователь выбрал героя мобильной версии 7 как образец, попросил полуботинки и такого же героя на десктопе. [Описание и промпты версии 8](revision-8.md). Выбор героя не является утверждением всего плана или дизайна.

[Возраст героя и промпты версии 7](revision-7.md): мужчина 36 лет, более зрелые пропорции при сохранении одежды и снаряжения. Оба макета обновлены; утверждение ещё не получено.

[Уточнения и промпты версии 6](revision-6.md): коричневая фетровая шляпа с загнутыми вверх боковыми полями; из-под кожаной куртки не выступают другие слои одежды. Оба макета обновлены и ожидают согласования.

[Коррекция света и промпт версии 5](revision-5.md): устранена вытянутая вниз освещённая дорога, предложен локальный радиальный свет вокруг факела. Исправлен только мобильный макет; правило освещения в плане едино для всех экранов. Утверждение ещё не получено.

[Уточнение обуви и промпты версии 4](revision-4.md): ботинки без отворотов. Оба макета обновлены встроенным image_gen и ожидают согласования пользователя.

[Уточнение героя и промпты версии 3](revision-3.md): короткая русая стрижка, коричневая кожаная куртка без капюшона. Оба макета обновлены встроенным image_gen и ожидают согласования.

Дата: 2026-09-13. Статус текущей версии 9: утверждена. Записи ниже о версиях 1–8 относятся к истории обсуждения и не отменяют этого утверждения.

Связанный [план 003](../../plans/003-first-level-visual-upgrade.md). Изображения созданы встроенным инструментом image_gen по прямому запросу пользователя до изменений кода. Это художественные макеты; они не являются скриншотами работающей игры или готовыми игровыми ресурсами.

- `01-mobile-tunnel.png`: вертикальный стартовый туннель, герой идёт вверх, крестовина движения и перезапуск.
- `02-desktop-junction.png`: широкий игровой экран с развилкой и фрагментами древней кладки.

На первом макете дальний пол слегка различим и герой расположен немного выше геометрического центра. Это отклонения макета: требования реализации сохраняются — центрирование героя и отсутствие видимой геометрии вне освещения. Точный радиус света, масштаб и компоновка определяются в дизайне после обсуждения изображений.

Версия 9 утверждена. Это не заменяет отдельного утверждения плана и технического дизайн-документа.

## Промпт 1

Use case: ui-mockup. Create a proposed actual gameplay screen for The True Path, a native 2D exploration maze adventure. Illustrated adventure book aesthetic, painted gouache large shapes, soft watercolor transitions, fine broken outlines, restrained grain; NOT pixel art, NOT photorealistic, NOT 3D. Orthographic top-down with slightly visible character back and rock faces, no horizon or perspective vanishing point. Young explorer in short vintage utilitarian travel jacket, linen shirt, brown trousers, high boots, small leather shoulder bag, messy hair, holding a wooden flaming torch clearly apart from head. Character exactly at image center, facing north/up, large enough to read but game scale about 8 percent image height. Warm amber torch creates a LIMITED localized soft pool of visible floor and nearest rock walls, outside is opaque deep charcoal darkness hiding ALL distant maze layout; opaque walls block light, no remote glowing details. Wet irregular cave stone, sparse roots and subdued moss, ancient fictional stonework, clear walkable floor boundaries. Palette deep shadow #152326, wet stone #435653, moss #586247, reflections #789A96, leather #71503C, torch #E7A24B, flame #FFE5A3, UI #DDD0AF. Mystery, solitude, danger and hope. Minimal field-journal UI dark translucent panel and fine old brass edges, no inventory, health, fuel, minimap or extra characters. No device frame, no explanatory labels, no watermarks. Portrait mobile gameplay composition 9:16. Start in a narrow tunnel coming from bottom toward top: hero at exact center walking upwards, a clear route ahead within the flame's reach and dark unseen continuation. Large readable four-direction touch D-pad bottom left with four separate arrow buttons arranged as a cross, comfortably inset from bottom and side, well below hero and pool of light. Small circular restart arrow button bottom right. Small understated title 'THE TRUE PATH' at top. Keep controls clean and usable, the scene is the focus.

## Промпт 2 — первая версия

Полный исходный промпт второй картинки не сохранился в документе из-за ошибки записи. Краткое описание для продолжения: широкий экран 16:9 в том же книжном стиле; герой с факелом по центру, развилка вверх и вправо, древняя арка, влажный камень и локальное освещение, заголовок сверху и перезапуск снизу справа. Это описание, а не дословный исходный промпт.

## Корректировки пользователя и версия 2

Пользователь запросил русые волосы, шляпу, более тусклый факел, сухую грунтовую дорогу и больше зелени, кустов и деревьев. Первые изображения сохраняются как история; текущими предложениями будут `01-mobile-tunnel-v2.png` и `02-desktop-junction-v2.png`. Изображения версии 2 также создаются встроенным image_gen с исходными макетами в качестве редактируемых изображений.

Для согласования предложено расположить участок возле входа и провалов свода, ночью. Днём туда поступает свет для растений; ночью ближайшую сцену освещает факел. В полностью тёмной глубине растительность уступает место корням. Сухая земля, мелкие камни и листовой опад заменяют лужи и блестящий каменный пол. Влажные участки стен допустимы.

Основания: [NPS — грунтовый пол Houchin’s Narrows](https://www.nps.gov/places/houchin-s-narrows.htm); [NPS — растительность у провалов Sunshine Cave](https://www.nps.gov/places/sunshine-cave.htm); [NPS — ограничения роста растений без солнечного света](https://www.nps.gov/grba/learn/nature/cave-life.htm). Сухое покрытие конкретной тропы и ночное время — художественное предложение, а не утверждение о любой тропической пещере.

Ни изображения, ни ночное время, ни обновлённый план пока не утверждены. Код не менялся.

Обе версии 2 созданы и сохранены. Визуально проверены шляпа, более светлые пряди, уменьшенное пламя, матовая грунтовая тропа и дополнительная растительность. Точный нейтральный русый оттенок следует проверить при создании ассета героя: огонь окрашивает волосы в золотистый тон. Ограничения макета по точному центрированию и дальности видимости сохраняются; при реализации их нельзя переносить вместо требований плана.

## Промпт редактирования мобильного макета, версия 2

Промпты ниже относятся к предыдущей версии; актуальное уточнение персонажа описано в разделе версии 3.

Edit this gameplay concept for The True Path, preserving the illustrated gouache adventure-book style, portrait aspect ratio, title, top-down camera, mobile four-arrow D-pad and restart button. Change hero to have clearly visible ash light-brown / dark-blond hair (Russian rusy, not dark brown, not bright yellow) peeking beneath a worn olive-brown expedition hat with modest brim. Keep vintage utilitarian jacket, leather bag, boots, handheld torch. Place hero precisely in center of entire screen facing up. Make flame about half as tall and considerably less bright, soft muted amber without white-hot bloom, keeping immediate path legible. Replace entire wet rocky path with DRY compacted earthy brown dirt, fine grit, scattered small stones and dry fallen leaves; matte surfaces, NO puddles, streams, wet reflections or cobblestone pavement. Add substantially more green vegetation bordering the path: fern clusters, leafy low shrubs, trailing vines, one modest tree trunk with roots and partial leaves growing beside an opening in the cave roof. Setting is a tropical cave entrance / collapsed-roof passage AT NIGHT, plants receive daylight by day, now only torch illuminates nearby scene. Preserve cave rock enclosure and worn ruin fragment. No moonbeams, no daytime glow. Foliage stays clear of walkable path and controls. Make the visible torch pool smaller, distant floor and vegetation completely fade into opaque charcoal beyond about three hero body heights; do not brighten entire image to compensate for dimmer torch. No new UI or game mechanics.

## Промпт редактирования широкого макета, версия 2

Edit this landscape gameplay concept for The True Path. Preserve illustrated gouache adventure-book aesthetic, orthographic top-down view, centered young explorer walking upwards, title at top, restart icon bottom right, ancient arch and readable cave junction with north and right routes. Change hero hair to ash light-brown / dark blond (Russian rusy, visibly light natural brown beneath brim) and add worn olive-brown modest-brim expedition hat. Keep vintage jacket, leather satchel and boots. Reduce torch flame height by half and significantly soften its brightness: dim muted amber, no white-hot core or oversized bloom, modest localized readable light. Replace all wet stone floor and puddles with DRY matte compacted brown soil, scattered fine gravel, occasional small embedded stones, dry leaves. No water reflections, no paved road. Substantially increase vegetation along cave margins: rich green ferns, leafy shrubs, climbing vines covering parts of the old arch, one small tree with visible trunk and partial crown beside a collapsed roof opening. This is near the cave entrance and roof openings AT NIGHT: plants get daylight by day but currently only torch reveals them. No sunbeams, no ambient revealing of the rest of the maze. Preserve underground enclosure, put plants outside clear navigable track. Outside small local torch radius smoothly fade all geometry to opaque deep charcoal. Keep hero precisely at full image center and entire framing unchanged. No new buttons, inventory or mechanics.
