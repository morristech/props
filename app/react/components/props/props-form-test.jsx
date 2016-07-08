import React from 'react';
import TestUtils from 'react-addons-test-utils';
import expect from 'expect';

import PropsForm from './props-form';

describe('render', () => {
  const onPropSubmit = expect.createSpy();
  const onThanksTextChange = expect.createSpy();
  const onFormLoad = expect.createSpy();
  const onSelectChange = expect.createSpy();
  const defaultProps = {
    avatars: ['https://test1.img'],
    selected_users: [{ value: 1, label: 'Test User', avatarUrl: 'https://test1.img' }],
    users: [
      { value: 1, label: 'Test User', avatarUrl: 'https://test1.img' },
      { value: 2, label: 'Test User 2', avatarUrl: 'https://test2.img' },
    ],
    selected_users_ids: ['1'],
    prop_creation_errors: {},
    prop_creation_request: false,
    thanksText: 'thanks',
    onPropSubmit,
    onThanksTextChange,
    onFormLoad,
    onSelectChange,
  };

  const component = TestUtils.renderIntoDocument(
    <PropsForm {...defaultProps} />
  );

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, PropsForm)).toExist();
  });
});
