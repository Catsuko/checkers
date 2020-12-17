import React, { Component, Fragment } from 'react'
import Token from './Token'

export default class Square extends Component {

  state = {
    isSelected: false
  }

  submitButton = React.createRef()

  select = () => this.setState({ isSelected: true }, this.submit)

  submit = () => this.submitButton.current.click()

  render() {
    const props = this.props
    const { isSelected } = this.state
    return (
      <div className={`square flex items-center justify-center ${props.id ? 'occupied' : ''}`}>
        {isSelected && <Fragment>
          <input type='hidden' value={props.position} name='position' />
          <input type='submit' className='dn' ref={this.submitButton} />
        </Fragment>}
        {props.id && <Token key={props.id} isSelected={props.selectedToken == props.id} {...props} />}
        {props.selectedToken && !props.id && <button type='button' onClick={this.select} className='w-100 h-100 bn outline-none bg-transparent' />}
      </div>
    )
  }
}
