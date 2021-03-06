#######
Morelia
#######

.. image:: https://img.shields.io/pypi/wheel/Morelia.svg
    :target: https://pypi.python.org/pypi/Morelia/
    :alt: Wheel Status

.. image:: https://img.shields.io/pypi/pyversions/Morelia.svg
    :target: https://pypi.python.org/pypi/Morelia/
    :alt: Python versions

.. image:: https://img.shields.io/pypi/v/Morelia.svg
    :target: https://pypi.python.org/pypi/Morelia/
    :alt: Latest Version

.. image:: https://img.shields.io/pypi/l/Morelia.svg
    :target: https://pypi.python.org/pypi/Morelia/
    :alt: License

.. image:: https://travis-ci.org/kidosoft/Morelia.svg?branch=master
    :target: https://travis-ci.org/kidosoft/Morelia
    :alt: Build status

.. image:: https://coveralls.io/repos/kidosoft/Morelia/badge.svg
    :target: https://coveralls.io/r/kidosoft/Morelia
    :alt: Coverage

.. image:: https://readthedocs.org/projects/morelia/badge/?format=svg
    :target: https://morelia.readthedocs.io
    :alt: Documentation

.. image:: https://pyup.io/repos/github/kidosoft/Morelia/shield.svg
    :target: https://pyup.io/repos/github/kidosoft/Morelia/
    :alt: Updates

.. image:: https://img.shields.io/badge/code%20style-black-000000.svg
    :target: https://github.com/ambv/black

Morelia is a Python Behavior Driven Development (BDD) library.

BDD is an agile software development process that encourages
collaboration between developers, QA and business participants.

Test scenarios written in natural language make BDD foundation.
They are comprehensible for non-technical participants who wrote them
and unambiguous for developers and QA.

Morelia makes it easy for developers to integrate BDD into their existing
unittest frameworks.  It is easy to run under nose, pytest, tox, trial or integrate
with django, flask or any other python framework because no special code
have to be written.

You as developer are in charge of how tests are organized. No need to fit into
rigid rules forced by some other BDD frameworks.

**Mascot**:

.. image:: http://www.naturfoto.cz/fotografie/ostatni/krajta-zelena-47784.jpg

Installation
============

.. code-block:: console

    pip install morelia

Quick usage guide
=================

Write a feature description:

.. code-block:: cucumber

    # calculator.feature

    Feature: Addition
        In order to avoid silly mistakes
        As a math idiot
        I want to be told the sum of two numbers

    Scenario: Add two numbers
        Given I have powered calculator on
        When I enter "50" into the calculator
        And I enter "70" into the calculator
        And I press add
        Then the result should be "120" on the screen


Create standard Python's `unittest` and hook Morelia into it:

.. code-block:: python

    # test_acceptance.py

    import unittest

    from morelia import verify


    class CalculatorTestCase(unittest.TestCase):
    
        def test_addition(self):
            """ Addition feature """
            verify('calculator.feature', self)

Run test with your favourite runner: unittest, nose, py.test, trial. You name it!

.. code-block:: console

    $ python -m unittest -v test_acceptance  # or
    $ pytest test_acceptance.py  # or
    $ nosetests -v test_acceptance.py  # or
    $ trial test_acceptance.py  # or
    $ # django/pyramid/flask/(place for your favourite test runner)

And you'll see which steps are missing:

.. code-block:: python

    F
    ======================================================================
    FAIL: test_addition (test_acceptance.CalculatorTestCase)
    Addition feature.
    ----------------------------------------------------------------------
    Traceback (most recent call last):
      File "(..)test_acceptance.py", line 31, in test_addition
        verify(filename, self)
      File "(..)/morelia/__init__.py", line 120, in verify
        execute_script(feature, suite, scenario=scenario, config=conf)
      File "(..)/morelia/parser.py", line 59, in execute_script
        assert not_found == set(), message
    AssertionError: Cannot match steps:

        def step_I_have_powered_calculator_on(self):
            r'I have powered calculator on'

            raise NotImplementedError('I have powered calculator on')

        def step_I_enter_number_into_the_calculator(self, number):
            r'I enter "([^"]+)" into the calculator'

            raise NotImplementedError('I enter "50" into the calculator')

        def step_I_enter_number_into_the_calculator(self, number):
            r'I enter "([^"]+)" into the calculator'

            raise NotImplementedError('I enter "70" into the calculator')

        def step_I_press_add(self):
            r'I press add'

            raise NotImplementedError('I press add')

        def step_the_result_should_be_number_on_the_screen(self, number):
            r'the result should be "([^"]+)" on the screen'

            raise NotImplementedError('the result should be "120" on the screen')

    ----------------------------------------------------------------------
    Ran 1 test in 0.013s

    FAILED (failures=1)

Now implement steps with standard `TestCases` that you are familiar:

.. code-block:: python

    # test_acceptance.py

    import unittest

    from morelia import verify
    

    class CalculatorTestCase(unittest.TestCase):
    
        def test_addition(self):
            """ Addition feature """
            verify('calculator.feature', self)
    
        def step_I_have_powered_calculator_on(self):
            r'I have powered calculator on'
            self.stack = []

        def step_I_enter_a_number_into_the_calculator(self, number):
            r'I enter "(\d+)" into the calculator'  # match by regexp
            self.stack.append(int(number))
    
        def step_I_press_add(self):  # matched by method name
            self.result = sum(self.stack)
    
        def step_the_result_should_be_on_the_screen(self, number):
            r'the result should be "{number}" on the screen'  # match by format-like string
            self.assertEqual(int(number), self.result)


And run it again:

.. code-block:: console

    $ python -m unittest test_acceptance

    Feature: Addition
        In order to avoid silly mistakes
        As a math idiot
        I want to be told the sum of two numbers
    Scenario: Add two numbers
        Given I have powered calculator on                       # pass  0.000s
        When I enter "50" into the calculator                    # pass  0.000s
        And I enter "70" into the calculator                     # pass  0.000s
        And I press add                                          # pass  0.001s
        Then the result should be "120" on the screen            # pass  0.001s
    .
    ----------------------------------------------------------------------
    Ran 1 test in 0.028s

    OK

Note that Morelia does not waste anyone's time inventing a new testing back-end
just to add a layer of literacy over our testage. Steps are miniature `TestCases`.
Your onsite customer need never know, and your unit tests and customer tests
can share their support methods. The same one test button can run all TDD and BDD tests.

Look at example directory for a little more enhanced example and read full
documentation for more advanced topics.

Documentation
=============

Full documentation is available at http://morelia.readthedocs.org/en/latest/index.html

.. image:: http://zeroplayer.com/images/stuff/sneakySnake.jpg
.. _the cheeseshop: http://pypi.python.org/pypi/Morelia/
.. _GitHub: http://github.com/kidosoft/Morelia/

Credits
---------

This package was created with Cookiecutter_ and the `kidosoft/cookiecutter-pypackage`_ project template.

[ ~ Dependencies scanned by `PyUp.io`_ ~ ]

.. _Cookiecutter: https://github.com/audreyr/cookiecutter
.. _`kidosoft/cookiecutter-pypackage`: https://github.com/kidosoft/cookiecutter-pypackage
.. _`PyUp.io`: https://pyup.io/
