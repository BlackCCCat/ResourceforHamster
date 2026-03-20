// Expose 26-key letter specs through a stable interface while delegating template expansion to shared helpers.
local letter26Shared = import '../specs/letter26Shared.libsonnet';
local letters = [entry[0] for entry in letter26Shared.entries];

{
  letters: letters,

  get26KeySpecs(orientation, keyboardLayout)::
    letter26Shared.buildSpecs(orientation, keyboardLayout),
}
