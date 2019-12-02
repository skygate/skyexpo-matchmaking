import React from 'react';
import { Redirect, Router, Route, Switch } from 'react-router-dom';

import { history } from '../history';
import { WelcomePage } from '../welcomePage/WelcomePage';
import { RegisterCompanyForm } from '../companyRegistrationForm/container/RegisterCompanyForm';
import { InvestorTypePage } from '../investorTypePage/InvestorTypePage';
import {
    startupFormSteps,
    companyInvestorFormSteps,
    individualInvestorFormSteps,
} from '../helpers/formSteps';
import {
    startupInitialValues,
    companyInvestorInitialValues,
    individualInvestorInitialValues,
} from '../helpers/formInitialValues';
import {
    startupValidationSchemas,
    companyInvestorValidationSchemas,
    individualInvestorValidationSchemas,
} from '../helpers/validationSchemas';

export const MainRouter = () => (
    <Router history={history}>
        <Switch>
            <Route exact path="/">
                <WelcomePage />
            </Route>
            <Route exact path="/startup">
                <RegisterCompanyForm
                    formSteps={startupFormSteps}
                    initialValues={startupInitialValues}
                    validationSchemas={startupValidationSchemas}
                />
            </Route>
            <Route exact path="/investor">
                <InvestorTypePage />
            </Route>
            <Route exact path="/investor/company">
                <h1>Company</h1>
                <RegisterCompanyForm
                    formSteps={companyInvestorFormSteps}
                    initialValues={companyInvestorInitialValues}
                    validationSchemas={companyInvestorValidationSchemas}
                />
            </Route>
            <Route exact path="/investor/individual">
                <h1>Individual</h1>
                <RegisterCompanyForm
                    formSteps={individualInvestorFormSteps}
                    initialValues={individualInvestorInitialValues}
                    validationSchemas={individualInvestorValidationSchemas}
                />
            </Route>
            <Redirect to="/" />
        </Switch>
    </Router>
);
