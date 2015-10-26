import React from 'react/addons';
const TestUtils = React.addons.TestUtils;
import expect from 'expect';
import Prop from './prop';

describe('props/vote', () => {
  const onUpvote = expect.createSpy();
  const defaultProps = {
    prop: {
      body: 'prop body',
      propser: {
        id: 1,
        avatarUrl: 'https://test1.img',
        name: 'user name',
      },
      users: [{
        id: 1,
        avatarUrl: 'https://test1.img',
        name: 'user name',
      }],
      createdAt: Date.parse('2015/10/10 12:00:00'),
      upvotesCount: 10,
      isUpvotePosssible: true,
    },
    onUpvote: onUpvote,
  };

  const component = TestUtils.renderIntoDocument(
    <Prop {...defaultProps}/>
  );

  it('renders', () => {
    expect(TestUtils.findRenderedComponentWithType(component, Prop)).toExist();
  });
});
