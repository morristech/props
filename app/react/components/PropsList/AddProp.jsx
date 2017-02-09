import React, { Component } from 'react';
import cx from 'classnames';
import Select from 'react-select';
import 'react-select/dist/react-select.css';
import { forIn } from 'lodash';
import styles from './style.css';

class AddProp extends Component {
  constructor(props) {
    super(props);
    this.state = {
      value: [],
    };

    this.handleSelectChange = this.handleSelectChange.bind(this);
  }

  getOptions() {
    const options = [];
    const data = this.props.users;
    forIn(data, (value) => {
      options.push({ label: value.name, value: value.id });
    });
    return options;
  }

  handleSelectChange(value) {
    console.log('You\'ve selected:', value);
    this.setState({ value });
  }

  render() {
    return (
      <div className="row">
        <div className="col-xs-12">
          <div
            className={cx(
              'jumbotron',
              styles.grid,
            )}
          >
            <form>
              <Select
                multi
                disabled={false}
                value={this.state.value}
                placeholder="Whom do you want to give a prop to?"
                options={this.getOptions()}
                onChange={this.handleSelectChange}
              />
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default AddProp;
