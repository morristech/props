import React, { PropTypes } from 'react';
import PropComponent from '../PropsList/Prop';

const UserProps = ({ receivedProps, givenProps }) => (
  <div className="row">
    <div className="col-md-6">
      <h2>Received props</h2>
      <ul className="list-unstyled">
        {
          receivedProps.map(prop => (
            <PropComponent
              key={prop.id}
              prop={prop}
              vote={false}
            />
          ))
        }
      </ul>
    </div>
    <div className="col-md-6">
      <h2>Given props</h2>
      <ul className="list-unstyled">
        {
          givenProps.map(prop => (
            <PropComponent
              key={prop.id}
              prop={prop}
              vote={false}
            />
          ))
        }
      </ul>
    </div>
  </div>
);

UserProps.propTypes = {
  receivedProps: PropTypes.arrayOf(PropTypes.object),
  givenProps: PropTypes.arrayOf(PropTypes.object),
};

UserProps.defaultProps = {
  receivedProps: [],
  givenProps: [],
};

export default UserProps;
