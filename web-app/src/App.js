import React from 'react';
import { Redirect, Router, Route, Switch } from 'react-router-dom';

import './App.css';
import 'antd/dist/antd.css';

import { RegisterCompanyForm } from './companyRegistrationForm/container/RegisterCompanyForm';
import { WelcomePage } from './welcomePage/WelcomePage';
import { history } from './history';

const App = () => (
    <div className="App">
        <Router history={history}>
            <Switch>
                <Route exact path="/">
                    <WelcomePage />
                </Route>
                <Route exact path="/startup">
                    <RegisterCompanyForm />
                </Route>
                <Route exact path="/company">
                    <h1>Company</h1>
                </Route>
                <Redirect to="/" />
            </Switch>
        </Router>
    </div>
);

export default App;
