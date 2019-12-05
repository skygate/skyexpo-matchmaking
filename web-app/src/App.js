import React from 'react';
import { Provider } from 'react-redux';

import './App.css';
import 'antd/dist/antd.css';

import { MainRouter } from './routing/MainRouter';
import { store } from './configureStore';
import { appInit } from './actions/init';

store.dispatch(appInit());

export const App = () => (
    <Provider store={store}>
        <div className="App">
            <MainRouter />
        </div>
    </Provider>
);
