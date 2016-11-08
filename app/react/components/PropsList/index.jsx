import React, { Component } from 'react';
import styles from './style.css';

class PropsList extends Component {
  render() {
    return (
      <div className={styles.main}>
        <h1>Props List View</h1>
        {
          this.props.propsList.map(prop =>
            <div>
              <h2>{prop.body}</h2>
              Propser: <strong>{prop.propser.name}</strong>
              <hr />
            </div>
          )
        }
      </div>
    );
  }
}

PropsList.propTypes = {

};

export default PropsList;
