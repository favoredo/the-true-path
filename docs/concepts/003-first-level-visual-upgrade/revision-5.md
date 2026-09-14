# Версия 5: радиальный свет в мобильном макете

Статус: ожидает согласования пользователя.

Пользователь указал, что нижняя часть дороги чрезмерно освещена, и уточнил: свет должен распространяться кругом вокруг факела. В версии 4 свет был вытянут вдоль коридора и раскрывал дальнюю дорогу. Это было несоответствием требованию ограниченного обзора.

Встроенным image_gen создан `01-mobile-tunnel-v5.png` на основе мобильного макета версии 4. Убрана освещённая полоса до нижнего края экрана; между локальной освещённой областью и кнопками теперь темнота. Визуально проверено исчезновение дальней дороги снизу. Это иллюстративный ориентир: точная радиальная функция и перекрытие стенами должны проверяться в движке, а не выводиться из формы этого изображения.

Единое правило для реализации: центр источника связан с факелом; радиус в плоскости уровня не зависит от пропорций экрана; свет плавно ослабевает во всех направлениях и перекрывается стенами. GUI не затемняется вместе с миром. Радиус в промпте относится только к правке изображения и не задаёт радиус игры.

Широкий макет остаётся `02-desktop-junction-v4.png`; в этой итерации не редактировался. План 003 обновлён и остаётся draft. Код не менялся.

## Промпт

Edit ONLY LIGHTING of this portrait mobile gameplay image. Critical correction: original has an incorrectly elongated brightly lit road extending to bottom screen. Replace with a SMALL CIRCULAR RADIAL POOL centered exactly on the torch flame (approximately x54%, y39% of full image), NOT on the hero feet and NOT on screen center. Radius in actual equal pixel distances in every direction, approximately 260 pixels for this 941x1672 reference. This means visible local environment is confined roughly to x250..770 and y390..920; smooth fade to COMPLETELY OPAQUE charcoal black outside that region. Below y950 ALL floor, stones, foliage, cave walls disappear fully into black: no visible trail running down to buttons. Similarly upper distant tunnel disappears fully above the circular pool. Do NOT stretch radius vertically to fit portrait frame. Strongest muted amber near flame, steadily weaker with radial distance, soft feathered edge about 70px. Rock walls naturally occlude light within circle. Keep hero readable inside lower portion of torch pool. NO additional fill lighting, no long spotlight cone, no bottom light, no moonlight, no luminous distant foliage. Preserve modest small flame brightness. KEEP GUI title and mobile controls fully visible and unchanged; darkness masks world only, not UI. Preserve exact hero appearance (hat, short ash light-brown hair, brown leather jacket NO HOOD, plain boots without folded cuffs), pose, position, camera, scene geometry and painterly book style. Do not redraw objects; conceal distant ones with darkness. The result must clearly look like a round localized light with black empty space separating illuminated world from bottom controls.

