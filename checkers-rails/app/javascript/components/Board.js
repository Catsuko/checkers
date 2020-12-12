import React, { Component } from 'react'
import Square from './Square'

export default class Board extends Component {

  state = {
    selectedToken: null
  }
  
  selectToken = (id) => this.setState({ selectedToken: id })

  selectSquare = (position) => {
    window.fetch(this.props.movePath, {
      method: 'put',
      headers: {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({position: position, piece_id: this.state.selectedToken})
    }).then(res=> location.reload());
  }

  render() {
    const { squares } = this.props
    const { selectedToken } = this.state
    return (
      <div className={`board ${selectedToken ? 'selecting-square' : 'selecting-token'}`}>
        <div className='squares flex flex-wrap justify-center items-center'>
          {squares.map((square, i) => <Square position={i} selectSquare={this.selectSquare} selectToken={this.selectToken} selectedToken={selectedToken} {...square} key={i} />)}
        </div>
      </div>
    )
  }
}
