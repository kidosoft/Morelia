Feature: Comments support

     Morelia processes this prose and runs the results as 
     a test suite. This prose describes how comments can be applied.
     # As a general rule: any line starting with "#" (with optional leading whitespaces
     # is considered as a comment

    Scenario: Comment can be put on separate line after any step
        When I put some comment after step on separate line
        # like this one
        Then scenario will pass

    Scenario: Comment can be put on separate line after scenario declaration
        # comment just after scenario declaration
        When I put some comment after scenario declaration
        Then scenario will pass

    Scenario: Comment can be put between table rows
        When I put comment between rows of table
            | data      |
            # this is a comment between table rows
            | some data | 
        Then I won't have comment in interpolated <data> from table

    Scenario: Comment can be put after examples declaration
        When I put comment after examples declaration
        Then I won't have comment in interpolated <data> from table

        Examples:
                # comment just after examples declaration
                | data       |
                | other data  |
