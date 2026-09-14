components { id: "script" component: "/main/game.script" }
components { id: "terrain" component: "/render/terrain.mesh" }
components { id: "decor" component: "/render/decor.mesh" }
components { id: "hero" component: "/render/hero.mesh" }
components { id: "mask" component: "/render/mask.mesh" }
components { id: "post" component: "/render/post.mesh" }
components { id: "fire" component: "/render/fire.mesh" }
embedded_components { id: "blocked" type: "sound" data: "sound: \"/assets/audio/blocked.wav\"\n" }
embedded_components { id: "victory" type: "sound" data: "sound: \"/assets/audio/victory.wav\"\n" }
