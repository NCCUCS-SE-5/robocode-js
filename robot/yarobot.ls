importScripts('../base-robot.js')

class YaRobot extends BaseRobot
  idle-count = 0
  dir = 0;

  do-search: !->
    @turn_turret_right 10
    @turn_right 10
	@shoot!

  onIdle: !->
    @idle-count++
    my-angle = @me.angle % 360

    if @my-var-enemy
      tiny-shoot = Math.random! * 10
      left-dist = my-angle + 360 - @my-var-enemy[0].angle
      if left-dist > 360
        left-dist = left-dist - 360

      right-dist = @my-var-enemy[0].angle - my-angle
      if right-dist < 0
        right-dist = 360 + right-dist

      if left-dist != right-dist
        if Math.random! > 0.5
          forward = true
        if left-dist > right-dist
          @turn_turret_right right-dist + 5 + tiny-shoot
        else
          @turn_turret_left left-dist + 5 + tiny-shoot
        @shoot!
      else
        @shoot!

      @my-var-enemy = undefined
    else
      if @idle-count > 3
        @do-search!
        if @idle-count > 4
          @do-search!
          if @idle-count > 5
            @do-search!
        return

	  if(@dir%2==0){
		  @turn_turret_left 30
          @turn_left 30
          @move_forwards 15
		  @shoot!
	  }else{
		  @turn_turret_left 30
          @turn_left 30
          @move_forwards 15
		  @shoot!
	  }


  onWallCollide: !->
    @move_opposide 10
    @turn_left 90
    @idle-count = 0

  onHit: !->
    #@turn_turret_right 180
    @idle-count = 0
    @yell "No! I'm hit!"

  onEnemySpot: !->
    @dir++;
    @my-var-enemy = @enemy-spot
    @shoot!
    @yell "Enemy spotted!"
    @idle-count = 0

tr = new YaRobot("The final boss")
