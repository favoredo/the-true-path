components {
  id: "script"
  component: "/main/game.script"
}
components {
  id: "maze"
  component: "/main/maze.tilemap"
}
components {
  id: "exit"
  component: "/main/exit.tilemap"
}
embedded_components {
  id: "blocked"
  type: "sound"
  data: "sound: \"/assets/audio/blocked.wav\"\n"
}
embedded_components {
  id: "victory"
  type: "sound"
  data: "sound: \"/assets/audio/victory.wav\"\n"
}
