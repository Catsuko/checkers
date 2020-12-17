import React, { Fragment } from 'react'

export default function Token(props) {
  const { in_game_id, light, selectToken, selectedToken, is_king } = props
  const isSelected = selectedToken == in_game_id
  return (
    <Fragment>
      {isSelected && <input type='hidden' name='piece_id' value={in_game_id} />}
      <button 
        type='button'
        className={`w-75 h-75 br-100 token ${light ? 'light' : 'dark'} ${isSelected ? 'selected' : ''} ${is_king ? 'king' : ''}`}
        onClick={() => selectToken(in_game_id)}
      >
      </button>
    </Fragment>
  )
}
