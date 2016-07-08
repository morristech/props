import expect from 'expect';
import reducer from './props';
import * as types from '../constants/action-types';

describe('props reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {})).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: {},
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: {},
      }
    );
  });

  it('handles RECEIVE_USER_PROPS', () => {
    const propsData = { props: [{}, {}], meta: {} };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: {},
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: propsData,
      }
    );
  });

  it('handles RECEIVE_USER_GIVEN_PROPS', () => {
    const propsData = { props: [{}, {}], meta: {} };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER_GIVEN_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: {},
        selected_users: [],
        thanksText: '',
        user_given_props: propsData,
        user_received_props: {},
      }
    );
  });

  it('handles RECEIVE_PROPS', () => {
    const propsData = { props: [{}, {}], meta: {} };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: propsData,
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: {},
      }
    );
  });


  it('handles REQUEST_USER_GIVEN_PROPS', () => {
    const previousState = {
      user_given_props: { props: [], meta: [] },
      user_received_props: {},
      props: {},
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER_GIVEN_PROPS,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: {},
      }
    );
  });

  it('handles REQUEST_USER_PROPS', () => {
    const previousState = {
      user_given_props: {},
      user_received_props: { props: [], meta: [] },
      props: {},
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER_PROPS,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: {},
      }
    );
  });

  it('handles REQUEST_PROPS', () => {
    const previousState = {
      user_given_props: {},
      user_received_props: {},
      props: { props: [], meta: [] },
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_PROPS,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: {},
      }
    );
  });
});
