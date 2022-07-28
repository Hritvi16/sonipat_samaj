import 'package:flutter/material.dart';
import 'package:sonipat_samaj/api/APIService.dart';
import 'package:sonipat_samaj/colors/MyColors.dart';
import 'package:sonipat_samaj/models/ProfessionListResponse.dart';

class Filter extends StatefulWidget {
  final bool mmarried, mumarried, cmarried, cumarried;
  final bool mrj, mnrj, crj, cnrj;
  final bool m1, m2, m3, m4, m5, m6, c1, c2, c3, c4, c5, c6;
  final List<String> mp;
  final List<String> cp;
  Filter({Key? key, required this.mmarried, required this.mumarried, required this.cmarried, required this.cumarried, required this.mrj, required this.mnrj, required this.crj, required this.cnrj, required this.m1, required this.m2, required this.m3, required this.m4, required this.m5, required this.m6, required this.c1, required this.c2, required this.c3, required this.c4, required this.c5, required this.c6, required this.mp, required this.cp}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool selected = true;
  late bool mmarried, mumarried, cmarried, cumarried;
  late bool mrj, mnrj, crj, cnrj;
  late bool m1, m2, m3, m4, m5, m6, c1, c2, c3, c4, c5, c6;

  List<Professions> professions = [];
  // List<bool> mp = [];
  // List<bool> cp = [];
  List<String> mp = [];
  List<String> cp = [];

  bool load = false;
  APIService apiService = APIService();

  @override
  void initState() {
    apiService.init();
    getProfessions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: load ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getType(),
                  getActions()
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getMaritalStatus(),
                      getJobStatus(),
                      getAgeGroup(),
                      getProfessionStatus(),
                    ],
                  ),
                ),
              )
            ],
          )
          : Center(
            child: CircularProgressIndicator(
              color: MyColors.colorPrimary,
            ),
          ),
        ),
      ),
    );
  }

  getType() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if(!selected) {
              selected = true;
              setState(() {

              });
            }
          },
          child: Container(
              height: 50,
              width: 110,
              alignment: Alignment.center,
              color: selected ? MyColors.colorPrimary.withOpacity(0.5) : MyColors.grey.withOpacity(0.5),
              child: Text(
                "MEMBER",
              )
          ),
        ),
        GestureDetector(
          onTap: () {
            if(selected) {
              selected = false;
              setState(() {

              });
            }
          },
          child: Container(
              height: 50,
              width: 110,
              alignment: Alignment.center,
              color: !selected ? MyColors.colorPrimary.withOpacity(0.5) : MyColors.grey.withOpacity(0.5),
              child: Text(
                  "CHILD"
              )
          ),
        )
      ],
    );
  }

  getActions() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            clear();
          },
          child: Container(
              height: 50,
              width: 110,
              alignment: Alignment.center,
              color: MyColors.colorPrimary.withOpacity(0.7),
              child: Text(
                  "CLEAR"
              )
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            apply();
          },
          child: Container(
              height: 50,
              width: 110,
              alignment: Alignment.center,
              color: MyColors.colorPrimary.withOpacity(0.7),
              child: Text(
                  "APPLY"
              )
          ),
        )
      ],
    );
  }

  getMaritalStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: MyColors.grey_2.withOpacity(0.5)))
          ),
          child: Text(
            (selected ? "Member" : "Child")+" Marital Status",
            style: TextStyle(
              color: MyColors.colorPrimary
            ),
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                Checkbox(
                  value: selected ? mmarried : cmarried,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        mmarried = value!;
                      else
                        cmarried = value!;
                    });
                  },
                ),
                Text(
                  "Married",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? mumarried : cumarried,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        mumarried = value!;
                      else
                        cumarried = value!;
                    });
                  },
                ),
                Text(
                  "Unmarried",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  getJobStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: MyColors.grey_2.withOpacity(0.5)))
          ),
          child: Text(
            (selected ? "Member" : "Child")+" Job Status",
            style: TextStyle(
              color: MyColors.colorPrimary
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: selected ? mrj : crj,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        mrj = value!;
                      else
                        crj = value!;
                    });
                  },
                ),
                Text(
                  "Require Job",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? mnrj : cnrj,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        mnrj = value!;
                      else
                        cnrj = value!;
                    });
                  },
                ),
                Text(
                  "Not Require Job",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  getAgeGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: MyColors.grey_2.withOpacity(0.5)))
          ),
          child: Text(
            (selected ? "Member" : "Child")+" Age Group",
            style: TextStyle(
              color: MyColors.colorPrimary
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: selected ? m1 : c1,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        m1 = value!;
                      else
                        c1 = value!;
                    });
                  },
                ),
                Text(
                  "Below 18 Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? m2 : c2,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        m2 = value!;
                      else
                        c2 = value!;
                    });
                  },
                ),
                Text(
                  "18 - 22 Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? m3 : c3,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        m3 = value!;
                      else
                        c3 = value!;
                    });
                  },
                ),
                Text(
                  "22 - 26 Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? m4 : c4,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        m4 = value!;
                      else
                        c4 = value!;
                    });
                  },
                ),
                Text(
                  "26 - 30 Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? m5 : c5,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        m5 = value!;
                      else
                        c5 = value!;
                    });
                  },
                ),
                Text(
                  "30 - 50 Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selected ? m6 : c6,
                  onChanged: (value) {
                    setState(() {
                      if(selected)
                        m6 = value!;
                      else
                        c6 = value!;
                    });
                  },
                ),
                Text(
                  "50+ Years",
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  getProfessionStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: MyColors.grey_2.withOpacity(0.5)))
          ),
          child: Text(
            (selected ? "Member" : "Child")+" Profession Status",
            style: TextStyle(
                color: MyColors.colorPrimary
            ),
          ),
        ),
        ListView.separated(
          itemCount: professions.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext buildContext, index) {
            return Divider(
              thickness: 1,
            );
          },
          itemBuilder: (BuildContext buildContext, index) {
            return getProfessionDesign(index);
          },
        ),
      ],
    );
  }

  getProfessionDesign(int ind) {
    return Row(
      children: [
        Checkbox(
          value: selected ? mp.contains(professions[ind].id!) : cp.contains(professions[ind].id!),
          // value: selected ? mp[ind] : cp[ind],
          onChanged: (value) {
            setState(() {
              if(selected)
                // mp[ind] = value!;
                mp.add(professions[ind].id!);
              else
                // cp[ind] = value!;
                cp.add(professions[ind].id!);
            });
          },
        ),
        Text(
          professions[ind].name??"",
          style: TextStyle(
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }

  set() {
    mmarried = widget.mmarried;
    cmarried = widget.cmarried;
    mumarried = widget.mumarried;
    cumarried = widget.cumarried;
    mrj = widget.mrj;
    mnrj = widget.mnrj;
    crj = widget.crj;
    cnrj = widget.cnrj;
    m1 = widget.m1;
    m2 = widget.m2;
    m3 = widget.m3;
    m4 = widget.m4;
    m5 = widget.m5;
    m6 = widget.m6;
    c1 = widget.c1;
    c2 = widget.c2;
    c3 = widget.c3;
    c4 = widget.c4;
    c5 = widget.c5;
    c6 = widget.c6;
    mp = widget.mp;
    cp = widget.cp;

    setState(() {

    });
  }

  clear() {
    mmarried = mumarried = cmarried = cumarried = false;
    mrj = mnrj = crj = cnrj = false;
    m1 = m2 = m3 = m4 = m5 = m6 = c1 = c2 = c3 = c4 = c5 = c6 = false;
    mp = [];
    cp = [];

    // mp = List.generate(professions.length, (index) => false);
    // cp = List.generate(professions.length, (index) => false);

    setState(() {

    });
  }

  void apply() {
    String query = "";
    String querym = "";
    String queryc = "";
    String mms = getMMS();
    String cms = getCMS();
    String mjs = getMJS();
    String cjs = getCJS();
    String mage = getMAge();
    String cage = getCAge();
    String mps = getMPS();
    String cps = getCPS();

    if(mms.isNotEmpty)
      querym = mms;
    if(mjs.isNotEmpty)
      querym = querym.isNotEmpty ? querym+" AND "+mjs : mjs;
    if(mage.isNotEmpty)
      querym = querym.isNotEmpty ? querym+" AND "+mage : mage;
    if(mps.isNotEmpty)
      querym = querym.isNotEmpty ? querym+" AND "+mps : mps;

    if(cms.isNotEmpty)
      queryc = cms;
    if(cjs.isNotEmpty)
      queryc = queryc.isNotEmpty ? queryc+" AND "+cjs : cjs;
    if(cage.isNotEmpty)
      queryc = queryc.isNotEmpty ? queryc+" AND "+cage : cage;
    if(cps.isNotEmpty)
      queryc = queryc.isNotEmpty ? queryc+" AND "+cps : cps;


    if(querym.isNotEmpty || queryc.isNotEmpty) {
      if(querym.isNotEmpty)
        query = "AND ((" + querym + ")";
      if(queryc.isNotEmpty)
        query = query.isNotEmpty ? query+" OR (" + queryc + ")" : "AND ((" + queryc + ")";
    }

    query = query.isNotEmpty ? " "+query+")" : query;
    print(query);

    // print("AND ($mps OR $cps)");
    // print("AND ($mjs OR $cjs)");
    // print("AND ($mms OR $cms)");
    // print("AND (("+mage+") OR ("+cage+"))");
    Navigator.pop(context, {
      "query" : query,
      "mmarried": mmarried, "cmarried": cmarried, "mumarried": mumarried, "cumarried": cumarried,
      "mrj": mrj, "mnrj": mnrj, "crj": crj, "cnrj": cnrj,
      "m1": m1, "m2": m2, "m3": m3, "m4": m4, "m5": m5, "m6": m6,
      "c1": c1, "c2": c2, "c3": c3, "c4": c4, "c5": c5, "c6": c6,
      "mp": mp, "cp": cp
    });
  }

  getMMS() {
    String ms = "";
    if (mmarried)
      ms = "a.IsMarried IN (1";
    if (mumarried)
      ms = ms.isNotEmpty ? ms+", 0" : "a.IsMarried IN (0";
    return ms.isNotEmpty ? ms+")" : ms;
  }

  getCMS() {
    String ms = "";
    if (cmarried)
      ms = "c.IsMarried IN (1";
    if (cumarried)
      ms = ms.isNotEmpty ? ms+", 0" : "c.IsMarried IN (0";
    return ms.isNotEmpty ? ms+")" : ms;
  }

  getMJS() {
    String js = "";
    if (mrj)
      js = "a.IsRequireJob IN (1";
    if (mnrj)
      js = js.isNotEmpty ? js+", 0" : "a.IsRequireJob IN (0";
    return js.isNotEmpty ? js+")" : js;
  }

  getCJS() {
    String js = "";
    if (crj)
      js = "c.IsRequireJob IN (1";
    if (cnrj)
      js = js.isNotEmpty ? js+", 0" : "c.IsRequireJob IN (0";
    return js.isNotEmpty ? js+")" : js;
  }
  getMAge()
  {
    String age = "";
    if(m1)
      age+="DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), a.DateOfBirth)), '%Y')+0 < 18";
    if(m2)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), a.DateOfBirth)), '%Y')+0 BETWEEN 18 AND 22";
    if(m3)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), a.DateOfBirth)), '%Y')+0 BETWEEN 22 AND 26";
    if(m4)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), a.DateOfBirth)), '%Y')+0 BETWEEN 26 AND 30";
    if(m5)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), a.DateOfBirth)), '%Y')+0 BETWEEN 30 AND 50";
    if(m6)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), a.DateOfBirth)), '%Y')+0 > 50";

    // return age.isNotEmpty ? "AND ($age)" : age;
    return age;
  }

  getCAge()
  {
    String age = "";
    if(c1)
      age+="DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), c.DateOfBirth)), '%Y')+0 < 18";
    if(c2)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), c.DateOfBirth)), '%Y')+0 BETWEEN 18 AND 22";
    if(c3)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), c.DateOfBirth)), '%Y')+0 BETWEEN 22 AND 26";
    if(c4)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), c.DateOfBirth)), '%Y')+0 BETWEEN 26 AND 30";
    if(c5)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), c.DateOfBirth)), '%Y')+0 BETWEEN 30 AND 50";
    if(c6)
      age+= (age.isNotEmpty ? " OR " : "") + "DATE_FORMAT(FROM_DAYS(DATEDIFF(now(), c.DateOfBirth)), '%Y')+0 BETWEEN > 50";

    // return age.isNotEmpty ? "OR ($age)" : age;
    return age;
  }

  String getMPS() {
    String ps = "";
    for (int i = 0; i < mp.length; i++) {

      // if(mp[i])
      //   ps += (professions[i].id!)+",";
      ps += (mp[i])+",";
    }
    return ps.isNotEmpty ? 'a.Profession IN ('+ps.substring(0, ps.lastIndexOf(','))+")" : ps;
  }

  String getCPS() {
    String ps = "";
    for (int i = 0; i < cp.length; i++) {

      // if(cp[i])
      //   ps += (professions[i].id!)+",";
        ps += (cp[i])+",";
    }
    return ps.isNotEmpty ? 'c.Profession IN ('+ps.substring(0, ps.lastIndexOf(','))+")" : ps;
  }

  Future<void> getProfessions() async {
    ProfessionListResponse professionListResponse = await apiService.getProfessions();

    if(professionListResponse.status=="Success" && professionListResponse.message=="Professions Retrieved") {
      professions = professionListResponse.professions ?? [] ;
    }

    load = true;

    set();
  }
}
