1. Removed unnecessary elif after return (pylint)
2. Fixed redundant-u-string-prefix violations (pylint)
3. Fixed trailing newline and whitespace violations (pylint)
4. Extracted generate header functions (1 per locale)
5. Pushed locale header logic into common function
6. Extracted date_entry formatting for en locale
7. Extracted date_entry formatting for nl locale
8. Extracted common date#month formatting for both locales
9. Extracted common date#day formatting for both locales
10. Extracted common date#year formatting for both locales
11. Abstracted knowledge of entry structure away from date formatting
12. Abstracted common formatting for all date fields
13. Pushed locale date formatting logic into common function
14. Switched to f-strings for easier date formatting
15. Extracted common method for finding next entry
16. Extracted handling of en locale USD change formatting
17. Extracted handling of nl locale USD change formatting
18. Extracted handling of en locale EUR change formatting
19. Extracted handling of nl locale EUR change formatting
20. Extracted common method for description formatting
21. Ensured all paths through #format_entries return a value (pylint)
22. Chained #create_entry factory method to LedgerEntry constructor
23. Pushed locale change formatting logic into common function
24. #format_entries no longer differs on locale
25. Switched to f-strings for easier detail line formatting
26. Extracted Ledger class for processing of all LedgerEntry objects
27. Moved majority of functions inside Ledger class
28. WIP cutover to class functions rather than static ones
29. Added LedgerPrinter class to hold high level printing/formatting concerns
30. WIP cutover to class functions rather than static ones
31. WIP data driving header generation
32. Header formatting simplification with str#ljust
33. Simplification of find_next_entry_in_order (still not quite sure what it does though)
34. Ignoring noisy pylint documentation warnings
35. Finally understand what find_next_entry_in_order is doing (it's sorting)
36. Removed need to mutate entries during processing
37. Extracted common change formatting for NL locale
38. Extracted common change formatting for EN locale
39. Slowly removing duplication in locale specific change formatting logic
40. More removal of common change formatting logic
41. Simplification of description formatting using ljust
42. Simplification of separation of groups of thousands using join
43. Externalised cent separator to format\_<LOCALE>\_change
44. Introducing subclasses to handle locale specific stuff
45. Specialising locale-specific header formatting in subclasses
46. Specialising locale-specific date formatting in subclasses
47. Specialising locale-specific change formatting in subclasses
48. WIP Specialising locale-specific change formatting in subclasses
49. WIP Specialising locale-specific change formatting in subclasses
50. Data driving currency specific logic
51. Final simplification of change handling
