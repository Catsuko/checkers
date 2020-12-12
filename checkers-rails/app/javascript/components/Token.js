import React from 'react'

export default function Token(props) {
  const { in_game_id, light, selectToken, selectedToken, is_king } = props
  return (
    <button 
      type='button'
      className={`w-75 h-75 br-100 token ${light ? 'light' : 'dark'} ${selectedToken == in_game_id ? 'selected' : ''} ${is_king ? 'king' : ''}`}
      onClick={() => selectToken(in_game_id)}
    >
    </button>
  )
}
