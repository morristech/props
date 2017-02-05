import React from 'react';
import cx from 'classnames';
import styles from './style.css';

const AddProp = () => {
  return (
    <div className="row">
      <div className="col-xs-12">
        <div
          className={cx(
            'jumbotron',
            styles.grid,
          )}
        >
          Form
        </div>
      </div>
    </div>
  );
};

export default AddProp;
