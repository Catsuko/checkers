import React from 'react'
import Token from './Token'

export default function Square(props) {
  return (
    <div className={`square flex items-center justify-center ${props.id ? 'occupied' : ''}`}>
      {props.id && <Token key={props.id} isSelected={props.selectedToken == props.id} {...props} />}
      {props.selectedToken && !props.id && <button type='button' onClick={() => props.selectSquare(props.position)} className='w-100 h-100 bn outline-none bg-transparent' />}
    </div>
  )
}
