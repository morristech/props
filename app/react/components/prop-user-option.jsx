import React, { PropTypes } from 'react';

export default class Option extends React.Component {
  static get propTypes() {
    return {
      addLabelText: PropTypes.string,
      className: PropTypes.string,
      mouseDown: PropTypes.func,
      mouseEnter: PropTypes.func,
      mouseLeave: PropTypes.func,
      option: PropTypes.object.isRequired,
      renderFunc: PropTypes.func,
    };
  }

  render() {
    const obj = this.props.option;
    return (
      <div
        className={this.props.className}
        onMouseEnter={this.props.mouseEnter}
        onMouseLeave={this.props.mouseLeave}
        onMouseDown={this.props.mouseDown}
        onClick={this.props.mouseDown}
      >
        <img className="user-small-face" src={obj.avatarUrl}></img>
        <span>{obj.label}</span>
      </div>
    );
  }
}
