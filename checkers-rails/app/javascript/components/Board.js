import React, { Component } from 'react'
import Square from './Square'

export default class Board extends Component {

  state = {
    selectedToken: null
  }
  
  selectToken = (id) => this.setState({ selectedToken: id })

  render() {
    const { squares } = this.props
    const { selectedToken } = this.state
    return (
      <div className={`board ${selectedToken ? 'selecting-square' : 'selecting-token'}`}>
        <div className='squares flex flex-wrap justify-center items-center'>
          {squares.map((square, i) => <Square position={i} selectToken={this.selectToken} selectedToken={selectedToken} {...square} key={i} />)}
        </div>
      </div>
    )
  }
}
