import React from 'react';

export default class Option extends React.Component {
  static get propTypes() {
    return {
      addLabelText: React.PropTypes.string,
      className: React.PropTypes.string,
      mouseDown: React.PropTypes.func,
      mouseEnter: React.PropTypes.func,
      mouseLeave: React.PropTypes.func,
      option: React.PropTypes.object.isRequired,
      renderFunc: React.PropTypes.func,
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
        onClick={this.props.mouseDown}>
        <img className="user-small-face" src={obj.avatarUrl}></img>
        <span>{obj.label}</span>
      </div>
    );
  }
}
