# Версия 8: полуботинки и единый образ героя

Статус: итоговые макеты ожидают согласования.

Пользователь выбрал героя мобильной версии 7 и запросил полуботинки, а также точно такого же героя в десктопной версии. Мобильный макет отредактирован первым: низкие коричневые кожаные полуботинки, брюки до обуви. Этот результат использован прямым визуальным референсом для десктопного героя. После первого переноса дополнительно исправлены пропорции и походка.

Итоги встроенного image_gen: `01-mobile-tunnel-v8.png` и `02-desktop-junction-v8.png`. Исходники сохранены. Сверены взрослый силуэт, длинные брюки, походка, куртка и снаряжение. Генеративный перенос не гарантирует пиксельного совпадения; в реализации обе платформы должны использовать один ресурс героя, что закреплено в плане 003. Выбор мобильного героя не является утверждением всего плана или технического дизайна.

Сохраняются ограничения макетов: точное центрирование и радиальная функция света проверяются в движке; широкий свет требует отдельной коррекции по правилу мобильной версии 5. Код не менялся.

## Промпт мобильной правки

Precise local edit of this mobile gameplay concept. User has selected THIS exact explorer as the definitive character. Change ONLY footwear and the adjacent trouser hems: replace tall boots with practical LOW-CUT BROWN LEATHER SHOES ending BELOW THE ANKLE (Russian polubotinki), sturdy rounded toes, modest soles. Full-length olive-brown trousers extend down to shoes; no boot shafts, no gaiters, no rolled cuffs. Preserve EXACTLY the selected man's physique, 36-year-old mature silhouette, height, pose, walking stride, short ash light-brown hair, brown felt hat with upcurled side brims, fitted brown leather jacket with flat back and no hood or protruding shirt, satchel, torch and hand. Preserve all scene, localized circular light and black lower screen, UI and title and book-painting style. Do not alter body size, redraw the hero upper body, brighten the scene or move anything.

## Промпт переноса на десктоп

Image 1 is the EDIT TARGET: landscape desktop scene. Image 2 is the AUTHORITATIVE CHARACTER REFERENCE: mobile scene with user-selected explorer. Replace ONLY the character in Image 1 with the SAME EXACT explorer from Image 2, as if transferring one identical game sprite, preserving his walking stride and silhouette. Copy mature 36-year-old male build, broader shoulders, longer adult legs, short ash light-brown haircut, shape of brown felt hat with upturned side brims, flat-backed brown leather jacket WITHOUT hood and no protruding shirt, satchel shape and strap, torch hand and small flame, full-length olive brown trousers and LOW-CUT brown leather SHOES below ankle (no boot shafts or cuffs). Match relative proportions precisely; do not use original desktop character anatomy, short legs or different outfit. Scale the copied character uniformly to desktop scene's game scale, center his body at original character location; no stretching. Image 2 is ONLY a character reference, do NOT copy its portrait framing, tunnel, darkness mask or controls. Keep Image 1 landscape environment, ruins, dry dirt junction, plants, title, restart icon, lighting and painterly style unchanged. Output one landscape image only.

## Дополнительная коррекция переноса

COMPOSITING correction. Image 1 is the source of the EXACT HERO to reuse, NOT merely style inspiration. Image 2 is the destination landscape BACKGROUND. Output Image 2 with its old hero completely replaced by the entire hero from Image 1, including the SAME WALKING POSE with one leg extended back, SAME long legs and broad torso, same hat silhouette, same jacket seams and belt, same satchel hanging at left hip, same right arm angle and small torch flame, same low brown shoes. Copy source hero silhouette faithfully like a cutout with UNIFORM scaling only, no anatomy reinterpretation. Destination existing hero has shorter legs, both feet almost side by side and wrong hat; do not preserve these. Source man has 36-year-old adult proportions, short ash light-brown hair, curled-side brown felt hat, brown leather jacket no hood, full-length trousers and low-cut shoes below ankle. Align source hero center to destination hero center. Preserve Image 2 landscape layout, ruins, vegetation, UI and background exactly, only integrate source character with contact shadow. Do not import mobile UI. One landscape image.

