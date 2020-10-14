# README

Minesweeper by @gtoroap

# Api

This API only have the following endpoints.

Notice: Every endpoint should prepend `/api/v1/` to work.

## Games

POST /games

### Request
Parameters
`rows` : integer
`columns` : integer
`mines`  : integer

### Response

`id`: integer
`rows` : integer
`columns` : integer
`mines`  : integer
`status` : text
`grid` : array

## Moves

POST /games/:id/moves

### Request
Parameters
`point_x` : integer
`point_y` : integer

### Response

`id`: integer
`game_id` : integer
`mines_around` : integer
`mine_found`  : boolean
`possibles_moves` : integer
`game_status` : text
`grid` : array
`flags` : array

## Flags

POST /games/:id/flags

### Request
Parameters
`point_x` : integer
`point_y` : integer

### Response

`id`: integer
`game_id` : integer
`point_x` : integer
`point_y` : integer
`kind` : text
