# -*- coding: utf-8 -*-

from tests.factories import (
  AngelInvestorFactory,
  InvestorProfileFactory,
  MatchFactory,
)


def test_match_string_representation():
    # GIVEN Match model
    investor = InvestorProfileFactory.build(
        angelinvestor=AngelInvestorFactory.build(),
    )
    match = MatchFactory.build(investor=investor)

    expected = '{startup}, {investor}, {result}'.format(
        startup=str(match.startup),
        investor=str(match.investor),
        result=match.result,
    )
    assert str(match) == expected
