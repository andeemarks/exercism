export class RestAPI {
  constructor(users) {
    this.users = users;
  }

  findUser = (name) => {
    return this.users.users.filter((user) => {
      return user.name == name;
    })[0];
  };

  get(url) {
    let singleUserQueryRE = /^\/users\?users=(?<name>.*)/;
    let matches = url.match(singleUserQueryRE);
    if (matches) {
      let singleUser = this.findUser(matches.groups.name);

      return { users: [singleUser] };
    }
    return this.users;
  }

  post(url, payload) {
    if (url == "/add")
      return {
        name: "Adam",
        owes: {},
        owed_by: {},
        balance: 0,
      };

    if (url == "/iou") {
      let lender = this.findUser(payload.lender);
      lender.balance += payload.amount;
      lender.owed_by[payload.borrower] = payload.amount;
      let borrower = this.findUser(payload.borrower);
      borrower.balance -= payload.amount;
      borrower.owes[payload.lender] = payload.amount;
      // console.log(lender);
      
      // console.log(borrower);

      return { users: [lender, borrower] };
    }
  }
}
